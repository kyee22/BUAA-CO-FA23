print("ori $1,$0,1")
for i in range(2,19):
    print("add ${},${},${}".format(i,i-1,i-1))
for i in range(19,32):
    print("sub ${},${},${}".format(i,i-1,i-2))