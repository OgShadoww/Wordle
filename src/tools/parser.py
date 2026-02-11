name = input("Please write the name of .txt file: \n")
result = input("Please write the name of output file: \n")

file = open(name, "+r")
output = open(result, "+w")

while True:
    s = file.readline()
    if s == "":
        break
    if len(s) != 6:
        continue
    else:
        output.write(s)
        print(f"Added + {s}") 

file.close()
output.close()
