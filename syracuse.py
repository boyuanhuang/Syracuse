import pandas as pd
import sys


def syracuse(n):
    current = int(n)
    series = []
    altimax = n
    dureevol = 0
    while current != 1:
        series.append(current)
        dureevol += 1
        if altimax < current:
            altimax = current

        if current % 2 == 0:
            current = current / 2
        else:
            current = current * 3 + 1
        current = int(current)
    series.append(current)
    dureealtitude = sum([1 for x in series if x > n])
    return series, int(altimax), int(dureevol), int(dureealtitude)


def write_syracuse_file(n, filename):
    series, altimax, dureevol, dureealtitude = syracuse(n)

    with open(filename, 'w') as f:
        f.write('n Un')
        f.write('\n')

        for i, number in enumerate(series):
            f.write(str(i) + ' ' + str(number))
            f.write('\n')
        f.write('altimax = ' + str(altimax))
        f.write('\n')

        f.write('dureevol = ' + str(dureevol))
        f.write('\n')
        f.write('dureealtitude = ' + str(dureealtitude))
    f.close()


if __name__ == "__main__":

    # ./ syracuse 15 f15.dat

    import sys

    ## Get input arguments
    n, filename = sys.argv[1], sys.argv[2]
    n = int(n)
    filename = str(filename)

    write_syracuse_file(n, filename)
