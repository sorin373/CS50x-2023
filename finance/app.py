import os
import re

from cs50 import SQL
from flask import Flask, flash, redirect, render_template, request, session
from flask_session import Session
from werkzeug.security import check_password_hash, generate_password_hash

from helpers import apology, login_required, lookup, usd

# Configure application
app = Flask(__name__)

# Custom filter
app.jinja_env.filters["usd"] = usd

# Configure session to use filesystem (instead of signed cookies)
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
Session(app)

# Configure CS50 Library to use SQLite database
db = SQL("sqlite:///finance.db")


@app.after_request
def after_request(response):
    """Ensure responses aren't cached"""
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Expires"] = 0
    response.headers["Pragma"] = "no-cache"
    return response


@app.route("/")
@login_required
def index():
    """Show portfolio of stocks"""

    user = session["user_id"]

    purchases = db.execute(
        "SELECT symbol, SUM(shares) AS totalShares FROM purchases WHERE user_id = (?) GROUP BY symbol HAVING totalShares > 0",
        user,
    )

    userCashDb = db.execute("SELECT cash FROM users WHERE id = ?", user)

    userCash = 0
    if userCashDb:
        userCash = userCashDb[0]["cash"]

    total = userCash

    for row in purchases:
        symbol = row["symbol"]
        quote = lookup(symbol)

        row["name"] = quote["name"]
        row["price"] = quote["price"]
        row["value"] = row["price"] * row["totalShares"]
        total += row["value"]
        row["total"] = row["price"] * row["totalShares"]

    return render_template(
        "index.html", stocks=purchases, cash=usd(userCash), total=usd(total)
    )


@app.route("/buy", methods=["GET", "POST"])
@login_required
def buy():
    """Buy shares of stock"""

    if request.method == "POST":
        user = session["user_id"]

        symbol = request.form.get("symbol")

        if not symbol:
            return apology("Not found!", 400)

        shares = request.form.get("shares")

        if shares.isdigit() == False:
            return apology("Invalid value!", 400)

        shares = int(shares)

        if shares < 0 or shares.is_integer() == False:
            return apology("Invalid value!", 400)

        if not symbol:
            return apology("Invalid form!", 400)
        getQuote = lookup(symbol)

        if not getQuote:
            return apology("Not found!", 400)

        price = getQuote["price"]

        userCashDb = db.execute("SELECT cash FROM users WHERE id = ?", user)
        userCash = userCashDb[0]["cash"]
        totalBought = price * shares
        userCash = userCash - totalBought

        if userCash < totalBought:
            return apology("Not enough funds!", 400)

        # CREATE TABLE purchases (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, user_id INTEGER NOT NULL, symbol TEXT NON NULL, shares INTEGER NOT NULL, price NUMERIC NOT NULL, total NUMERIC, FOREIGN KEY (user_id) REFERENCES users(id));
        db.execute("UPDATE users SET cash = (?) WHERE id = (?)", userCash, user)

        db.execute(
            "INSERT INTO purchases (user_id, symbol, shares, price) VALUES (?, ?, ?, ?)",
            user,
            symbol,
            shares,
            price,
        )

        db.execute(
            "INSERT INTO history (user_id, symbol, shares, price) VALUES (?, ?, ?, ?)",
            user,
            symbol,
            shares,
            price,
        )

        flash("Bought!")

        return redirect("/")
    else:
        return render_template("buy.html")


@app.route("/history")
@login_required
def history():
    """Show history of transactions"""

    # CREATE TABLE history (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, user_id INTEGER NOT NULL, symbol TEXT NOT NULL, shares NUMERIC NOT NULL, price NUMERIC NOT NULL, timestamp DATETIME DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (user_id) REFERENCES users(id));

    user = session["user_id"]
    userHistory = db.execute(
        "SELECT * FROM history WHERE user_id = (?) ORDER BY timestamp DESC;", user
    )

    return render_template("history.html", table=userHistory)


@app.route("/login", methods=["GET", "POST"])
def login():
    """Log user in"""

    # Forget any user_id
    session.clear()

    # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":
        # Ensure username was submitted
        if not request.form.get("username"):
            return apology("must provide username", 403)

        # Ensure password was submitted
        elif not request.form.get("password"):
            return apology("must provide password", 403)

        # Query database for username
        rows = db.execute(
            "SELECT * FROM users WHERE username = ?", request.form.get("username")
        )

        # Ensure username exists and password is correct
        if len(rows) != 1 or not check_password_hash(
            rows[0]["hash"], request.form.get("password")
        ):
            return apology("invalid username and/or password", 403)

        # Remember which user has logged in
        session["user_id"] = rows[0]["id"]

        # Redirect user to home page
        return redirect("/")

    # User reached route via GET (as by clicking a link or via redirect)
    else:
        return render_template("login.html")


@app.route("/logout")
def logout():
    """Log user out"""

    # Forget any user_id
    session.clear()

    # Redirect user to login form
    return redirect("/")


@app.route("/quote", methods=["GET", "POST"])
@login_required
def quote():
    """Get stock quote."""

    if request.method == "POST":
        symbol = request.form.get("symbol")

        if not symbol:
            return apology("Invalid form!", 400)
        getQuote = lookup(symbol)

        if not getQuote:
            return apology("Not found!", 400)

        return render_template("quoted.html", quote=getQuote)
    else:
        return render_template("quote.html")


@app.route("/change_password", methods=["GET", "POST"])
def change_password():
    session.clear()

    if request.method == "POST":
        username = request.form.get("username")
        oldPassword = request.form.get("oldPassword")
        newPassword = request.form.get("newPassword")
        confirmation = request.form.get("confirmation")

        table = db.execute("SELECT * from users WHERE username = ?", username)

        oldPasswordHash = table[0]["hash"]
        if not check_password_hash(oldPasswordHash, oldPassword) or len(table) != 1:
            return apology("Incorrect passowrd!", 400)

        if newPassword != confirmation:
            return apology("Password did not match!", 400)

        # https://docs.python.org/3/library/re.html
        if not re.search("[!@#$%^&*()]", newPassword):
            return apology(
                "Password must contain special characters such as: !@#$%^&*()", 400
            )

        if not re.search("[0-9]", newPassword):
            return apology("Password must contain digits!", 400)

        if not len(newPassword) > 5:
            return apology("Passowrd must have more than 5 characters!", 400)

        newHash = generate_password_hash(newPassword)
        db.execute(
            "UPDATE users SET hash = (?) WHERE username = (?)", newHash, username
        )

        return redirect("/login")

    return render_template("changePassword.html")


@app.route("/register", methods=["GET", "POST"])
def register():
    """Register user"""

    session.clear()
    if request.method == "POST":
        username = request.form.get("username")
        password = request.form.get("password")
        confirmation = request.form.get("confirmation")

        if not username:
            return apology("Invalid form!", 400)
        if not password:
            return apology("Invalid form!", 400)
        if not confirmation:
            return apology("Invalid form!", 400)

        if password != confirmation:
            return apology("Password did not match!", 400)

        # Check username
        rows = db.execute("SELECT * FROM users WHERE username = ?", username)
        if len(rows) > 0:
            return apology("Username is not available!", 400)

        # https://docs.python.org/3/library/re.html
        if not re.search("[!@#$%^&*()]", password):
            return apology(
                "Password must contain special characters such as: !@#$%^&*()", 400
            )

        if not re.search("[0-9]", password):
            return apology("Password must contain digits!", 400)

        if not len(password) > 5:
            return apology("Passowrd must have more than 5 characters!", 400)

        hash = generate_password_hash(password)
        db.execute("INSERT INTO users (username, hash) VALUES (?, ?)", username, hash)

        rows = db.execute("SELECT * FROM users WHERE username = ?", username)

        session["user_id"] = rows[0]["id"]

        return redirect("/login")
    else:
        return render_template("register.html")


@app.route("/sell", methods=["GET", "POST"])
@login_required
def sell():
    user = session["user_id"]
    table = db.execute("SELECT * FROM purchases WHERE user_id=?", user)

    if request.method == "POST":
        symbol = request.form.get("symbol")
        quote = lookup(symbol)
        shares = int(request.form.get("shares"))
        price = quote["price"]

        if shares < 0:
            return apology("Value can not be negative!", 400)

        userStocks = db.execute(
            "SELECT shares FROM purchases WHERE user_id = (?) AND symbol = (?)",
            user,
            symbol,
        )

        if not userStocks:
            return apology(f"User {user} does not own any shares of {symbol}!", 400)

        userShares = 0
        for stock in userStocks:
            userShares += int(stock["shares"])

        if userShares < shares:
            return apology(f"Not enough {symbol} shares available!", 400)

        userCashDb = db.execute("SELECT cash FROM users WHERE id = ?", user)
        userCash = userCashDb[0]["cash"]
        stockPrice = quote["price"]
        userCash += shares * stockPrice

        for stock in userStocks:
            if int(stock["shares"]) - shares <= 0:
                db.execute(
                    "DELETE FROM purchases WHERE user_id = (?) AND symbol = (?)",
                    user,
                    symbol,
                )
            else:
                remainingStocks = stock["shares"] - shares
                db.execute(
                    "UPDATE purchases SET shares = (?) WHERE user_id = (?) AND symbol = (?)",
                    remainingStocks,
                    user,
                    symbol,
                )

        db.execute("UPDATE users SET cash = (?) WHERE id = (?)", userCash, user)

        shares = -shares

        db.execute(
            "INSERT INTO history (user_id, symbol, shares, price) VALUES (?, ?, ?, ?)",
            user,
            symbol,
            shares,
            price,
        )

        return redirect("/")
    else:
        shares = []
        for row in table:
            symbol = row["symbol"]
            if symbol not in [item["symbol"] for item in shares]:
                shares.append(row)

        return render_template("sell.html", table=shares)
