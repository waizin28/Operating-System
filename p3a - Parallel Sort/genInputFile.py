import string
import random

string.ascii_letters
'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
numRecords = 27
f = open('input.txt', "w")
for currRecords in range(numRecords):
    for i in range(100):
        if i < 4:
            f.write(chr(random.randint(48,57)))
        elif i != 99:
            f.write(random.choice(string.ascii_letters))
        else:
            f.write("\n")

f.close()
