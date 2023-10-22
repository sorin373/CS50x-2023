import csv
import sys


def main():
    # TODO: Check for command-line usage
    if len(sys.argv) != 3:
        print("Usage: python dna.py data.csv sequence.txt")
        sys.exit(-1)

    # TODO: Read database file into a variable

    dataBase = []
    STRs = []

    with open(sys.argv[1], "r") as csvFile:
        reader = csv.DictReader(csvFile)

        # Adding STRs
        for field in reader.fieldnames:
            if field != reader.fieldnames[0]:
                STRs.append(field)

        for row in reader:
            for field in reader.fieldnames:
                if field != reader.fieldnames[0]:
                    row[field] = int(row[field])
            dataBase.append(row)
    csvFile.close()

    # TODO: Read DNA sequence file into a variable
    with open(sys.argv[2], "r") as dnaFile:
        dna = dnaFile.read()
    dnaFile.close()

    # TODO: Find longest match of each STR in DNA sequence
    counts = {}

    for __STR in STRs:
        _STR_count_ = longest_match(dna, __STR)
        counts[__STR] = _STR_count_

    # TODO: Check database for matching profiles

    for data in dataBase:
        isMatch = True
        for __STR in STRs:
            if data[__STR] != counts[__STR]:
                isMatch = False

        if isMatch == True:
            print(data["name"])
            sys.exit(0)

    print("No match")
    sys.exit(0)


def longest_match(sequence, subsequence):
    """Returns length of longest run of subsequence in sequence."""

    # Initialize variables
    longest_run = 0
    subsequence_length = len(subsequence)
    sequence_length = len(sequence)

    # Check each character in sequence for most consecutive runs of subsequence
    for i in range(sequence_length):
        # Initialize count of consecutive runs
        count = 0

        # Check for a subsequence match in a "substring" (a subset of characters) within sequence
        # If a match, move substring to next potential match in sequence
        # Continue moving substring and checking for matches until out of consecutive matches
        while True:
            # Adjust substring start and end
            start = i + count * subsequence_length
            end = start + subsequence_length

            # If there is a match in the substring
            if sequence[start:end] == subsequence:
                count += 1

            # If there is no match in the substring
            else:
                break

        # Update most consecutive matches found
        longest_run = max(longest_run, count)

    # After checking for runs at each character in seqeuence, return longest run found
    return longest_run


main()
