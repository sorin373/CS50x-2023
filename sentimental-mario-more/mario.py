# TODO
from cs50 import get_int


def main():
    print_pyramind(get_input())


def get_input():
    while True:
        input = get_int("Height: ")
        if input >= 1 and input <= 8:
            return input


def print_pyramind(height):
    for i in range(1, height + 1):
        j = height
        while j > i:
            print(" ", end="")
            j -= 1

        j = 1
        while j <= i:
            print("#", end="")
            j += 1

        print("  ", end="")

        j = 1
        while j <= i:
            print("#", end="")
            j += 1

        print()


main()
