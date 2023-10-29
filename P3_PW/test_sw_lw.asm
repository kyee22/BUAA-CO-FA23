ori $0,$zero,0x0000
ori $1,$zero,0x0001
ori $2,$zero,0x0202
ori $3,$zero,0x0005



sw $2,3($1)
lw $4,3($1)
sw $4,7($1)

add $2,$2,$3

sw $2,-1($3)
sw $2,-5($3)
lw $5,-1($3)
