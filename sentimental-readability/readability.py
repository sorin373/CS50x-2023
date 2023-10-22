# TODO


def main():
    s = input("Enter: ")

    words = getWords(s)
    letters = getLetters(s)
    sentences = getSentences(s)

    L = (letters / words) * 100
    S = (sentences / words) * 100

    index = round(0.0588 * L - 0.296 * S - 15.8)

    if index < 1:
        print("Before Grade 1")
    elif index < 16:
        print(f"Grade {index}")
    else:
        print("Grade 16+")


def getSentences(s):
    count = 0

    for c in s:
        if c == "." or c == "!" or c == "?":
            count += 1

    return count


def getLetters(s):
    count = 0

    for c in s:
        if (c >= "a" and c <= "z") or (c >= "A" and c <= "Z"):
            count += 1

    return count


def getWords(s):
    count = 0

    for c in s:
        if c == " ":
            count += 1

    return count + 1


if __name__ == "__main__":
    main()
