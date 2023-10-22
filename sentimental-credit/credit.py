# TODO
from cs50 import get_int


def main():
    n = get_int("Number: ")
    digit = valid(n)

    if digit != -1:
        while n > 99:
            n //= 10

        if digit == 15 and (n == 34 or n == 37):
            print("AMEX")
        elif digit == 16 and (n > 50 and n < 56):
            print("MASTERCARD")
        elif (digit == 13 or digit == 16) and (n // 10) % 10 == 4:
            print("VISA")
        else:
            print("INVALID")
    else:
        print("INVALID")


def valid(n):
    two_sum = 0
    sum = 0
    final_sum = 0
    digit = 0

    while n:
        digit += 1
        if digit % 2 == 0:
            digit_sum = 0
            d = (n % 10) * 2

            if d >= 10:
                while d > 0:
                    digit_sum += d % 10
                    d //= 10
            else:
                digit_sum = d
            two_sum += digit_sum
        else:
            sum += n % 10

        final_sum = two_sum + sum

        n //= 10

    if final_sum % 10 != 0:
        return -1

    return digit


if __name__ == "__main__":
    main()
