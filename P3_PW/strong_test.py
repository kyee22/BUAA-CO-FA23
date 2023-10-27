import random

def generate():

    op = random.randint(1,9)



    def generate_add():
        print("add ${},${},${}".format(random.randint(1,31),random.randint(1,31),random.randint(1,31)))
    def generate_sub():
        print("sub ${},${},${}".format(random.randint(1, 31), random.randint(1, 31), random.randint(1, 31)))

    def generate_lui():
        hex = ['0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f']
        imm = random.choice(hex) + random.choice(hex) + random.choice(hex) +random.choice(hex)
        print("lui ${},0x{}".format(random.randint(1,31),imm))

    def generate_lw():
        offset = ['0','4','8','12','16','20','24','28',
                  '32','36','40','44','48','52','56','60']
        print("lw ${},{}($0)".format(random.randint(1,31),random.choice(offset)))

    def generate_lw2():
        offset = ['0', '4', '-8', '-12', '-16', '-20', '-24', '-28',
                  '32', '-36', '-40', '-44', '-48', '-52', '-56', '-60']
        print("ori $1,$0,0x003c")
        print("lw ${},{}($1)".format(random.randint(1, 31), random.choice(offset)))

    def generate_sw():
        offset = ['0','4','8','12','16','20','24','28',
                  '32','36','40','44','48','52','56','60']
        print("sw ${},{}($0)".format(random.randint(1,31),random.choice(offset)))

    def generate_sw2():
        offset = ['0', '4', '-8', '-12', '-16', '-20', '-24', '-28',
                  '32', '-36', '-40', '-44', '-48', '-52', '-56', '-60']
        print("ori $1,$0,0x003c")
        print("sw ${},{}($1)".format(random.randint(1, 31), random.choice(offset)))
    if op == 1:
        generate_add()
    elif op == 2:
        generate_sub()
    elif op==3:
        generate_lui()
    elif op==4:
        generate_lw()
    elif op==5:
        generate_lw2()
    elif op==6:
        generate_sw()
    else:
        generate_sw2()

for i in range(700):
    generate()