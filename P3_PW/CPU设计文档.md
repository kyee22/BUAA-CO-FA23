# CPU设计文档

> 2023年《计算机组成》（实验）P3 Logisim单周期CPU设计文档
>
> *by 匡亦煊 22371092*

## 概述

- 处理器为 32 位单周期处理器，应支持的指令集为：`add, sub, ori, lw, sw, beq, lui, nop`，其中：
  - `nop` 为空指令，机器码 `0x00000000`，不进行任何有效行为（修改寄存器等）。
  - `add, sub` 按无符号加减法处理（不考虑溢出）。
- 需要采用**模块化**和**层次化**设计。顶层有效的驱动信号要求包括且仅包括**异步复位信号 reset**（clk 请使用内置时钟模块）。

## RTL描述分析

开始时，面对仅8条指令，我就因为被陷入反复的细节而感到困扰。

于是，我将指令大致分为3类，并归纳这些指令的RTL描述：

1. 运算类

   | 指令  | RTL描述                                               |
   | ----- | ----------------------------------------------------- |
   | `add` | $\rm R[rd] \leftarrow R[rs]+R[rt]$                    |
   | `sub` | $\rm R[rd]\leftarrow R[rs]-R[rt]$                     |
   | `ori` | $\rm R[rt]\leftarrow R[rs]\; OR\;zero\_extend(imm16)$ |
   | `lui` | $\rm R[rt]\leftarrow 高位\_extend(imm16)$             |

2. 访存类

   | 指令 | RTL描述                                                      |
   | ---- | ------------------------------------------------------------ |
   | `lw` | Addr $\leftarrow$ GPR[rs] + sign\_extend(imm16)<br>R[rt] $\leftarrow$ Mem[Addr] |
   | `sw` | Addr $\leftarrow$ R[rs] + sign\_extend(imm16)<br/>Mem[Addr] $\leftarrow$ GPR[rt] |

3. 跳转类

   | 指令  | RTL描述                                                      |
   | ----- | :----------------------------------------------------------- |
   | `beq` | $\rm PC \leftarrow (R[rs]==R[rt])\,?\,PC+4+sign\_extend(imm16<<2):PC+4$ |

将RTL描述放在一起提取 **共性** 之后，可以发现，excute的部分无非就是：ALU运算、写入到寄存器、写入到DM。而决定每条指令 **个性** 的就是一些控制信号。

## 控制信号分析

仔细辨别各指令共性下的个性后，设计控制信号若干如下：

* NPC模块的 `NPCOp` 控制信号，控制：

  * 简单的PC+4
  * 有条件跳转`beq`、`blt`……

  （下面的是待扩展的）

  * 无条件跳转`j`、`jal`（与`j`相比，需要回写$\rm R[31]=PC+4$）
  * 跳转到寄存器`jr`

* EXT模块的 `EXTOp` 控制信号，控制：

  * 00：zero extend
  * 01：sign extend
  * 10：加载到高位（`lui`）

* 写入寄存器的**来源数据**控制信号 `RegSrc`，控制：

  * 00：ALU的res
  * 01：DM的MemRD
  * 10：EXT的extend(imm)

* 写入寄存器的**目的地址**控制信号 `RegDst`，控制：

  * 0：rt
  * 1：rd

* 写入寄存器的使能信号 `RegWrite`

* ALU模块的B端信号的来源控制信号 `ALUSrc`，控制：

  * 0：GRF的RegRD2
  * 1：EXT的extend(imm)

* ALU模块的运算符控制信号 `ALUOp`

  * 00：加
  * 01：减
  * 10：或

* 写入DM模块的使能信号 `MemWrite`

## 关键模块构造

### 2. NPC

#### 端口定义

| 信号名称         | 方向 | 描述                                                         |
| ---------------- | ---- | ------------------------------------------------------------ |
| PC[31:0]         | I    | 当前PC值                                                     |
| NPCOp[1:0]       | I    | 控制PC更新的方式，具体见功能定义                             |
| Extend_Imm[31:0] | I    | EXT模块输出端的立即数                                        |
| eq?              | I    | ALU模块输出端的`R[rs]==R[rt]`判断结果<br>0：不相等<br>1：相等 |
| NPC[31:0]        | O    | 下一个PC值                                                   |

### 功能定义



## 测试

### 运算类指令测试

测试 `ori` 指令和GRF阵列。

通过Python程序生成指令

```python
for i in range(32):
    print("ori ${},$zero,0x{:0>2d}{:0>2d}".format(i,i,i))
```

指令：

```
v2.0 raw
34000000
34010101
34020202
34030303
34040404
34050505
34060606
34070707
34080808
34090909
340a1010
340b1111
340c1212
340d1313
340e1414
340f1515
34101616
34111717
34121818
34131919
34142020
34152121
34162222
34172323
34182424
34192525
341a2626
341b2727
341c2828
341d2929
341e3030
341f3131
```

MARS结果：

![image-20231026215017476](C:\Users\Arren\AppData\Roaming\Typora\typora-user-images\image-20231026215017476.png)

CPU结果：

![image-20231026215121545](C:\Users\Arren\AppData\Roaming\Typora\typora-user-images\image-20231026215121545.png)

测试 `add` 和 `sub`

```python
print("ori $1,$0,1")
for i in range(2,19):
    print("add ${},${},${}".format(i,i-1,i-1))
for i in range(19,32):
    print("sub ${},${},${}".format(i,i-1,i-2))
```

MARS结果：

![image-20231026215937958](C:\Users\Arren\AppData\Roaming\Typora\typora-user-images\image-20231026215937958.png)

CPU结果：

![image-20231026220456064](C:\Users\Arren\AppData\Roaming\Typora\typora-user-images\image-20231026220456064.png)

### 访存类指令测试



```assembly
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
```

MARS结果：

![image-20231026221710203](C:\Users\Arren\AppData\Roaming\Typora\typora-user-images\image-20231026221710203.png)



![image-20231026221736808](C:\Users\Arren\AppData\Roaming\Typora\typora-user-images\image-20231026221736808.png)

CPU结果：

![image-20231026222100236](C:\Users\Arren\AppData\Roaming\Typora\typora-user-images\image-20231026222100236.png)



![image-20231026222210649](C:\Users\Arren\AppData\Roaming\Typora\typora-user-images\image-20231026222210649.png)

### 跳转类指令测试





MARS结果：

![image-20231026224706558](C:\Users\Arren\AppData\Roaming\Typora\typora-user-images\image-20231026224706558.png)



![image-20231026224718943](C:\Users\Arren\AppData\Roaming\Typora\typora-user-images\image-20231026224718943.png)



CPU结果：

![image-20231026225300029](C:\Users\Arren\AppData\Roaming\Typora\typora-user-images\image-20231026225300029.png)

![image-20231026225330314](C:\Users\Arren\AppData\Roaming\Typora\typora-user-images\image-20231026225330314.png)

我使用到的一个反汇编Python程序（来自Github）

```python
# -*- coding: utf-8 -*-
"""
Created on Sat Nov  9 17:09:35 2019

@author: wzk
"""
import time
import os


print("Function: machine code to mips code\n\
Instructions included: 56 (55 from mips-c instruction set and 'nop')\n\
Please copy the machine code into in.txt and put it into the same folder \
as this .py file.\nPress Enter to continue")

def bi_to_hex(a):
    return hex(int(str(int(a,2))))


machine=[]
hex_to_bi={"0":"0000","1":"0001","2":"0010","3":"0011",
           "4":"0100","5":"0101","6":"0110","7":"0111",
           "8":"1000","9":"1001","a":"1010","b":"1011",
           "c":"1100","d":"1101","e":"1110","f":"1111"}
reg={"0":"$0",  "1":"$at", "2":"$v0", "3":"$v1",
     "4":"$a0", "5":"$a1", "6":"$a2", "7":"$a3",
     "8":"$t0", "9":"$t1", "10":"$t2", "11":"$t3",
     "12":"$t4", "13":"$t5", "14":"$t6", "15":"$t7",
     "16":"$s0", "17":"$s1", "18":"$s2", "19":"$s3",
     "20":"$s4", "21":"$s5", "22":"$s6", "23":"$s7",
     "24":"$t8", "25":"$t9", "26":"$k0", "27":"$k1",
     "28":"$gp", "29":"$sp", "30":"$fp", "31":"$ra"}


mark=0
while mark==0:
    input()
    try:
         file_in = open('new.txt','r+')
         file_out = open('out.txt','wt')
         mark = 1
    except:
         print("in.txt does not exist. Please try again.")

         
out=["" for i in range(20000)]
labelcount=1
mipscount=0
label={}
for line in file_in:
    machine.append(line[:-1])
    
for hexcode in machine:
    
    bicode=""
    for char in hexcode:
        bicode += hex_to_bi[char]
        
    op=bicode[0:6]
    func=bicode[26:32]
    rs=reg[str(int(bicode[6:11],2))]
    rt=reg[str(int(bicode[11:16],2))]
    rd=reg[str(int(bicode[16:21],2))]
    shamt=bicode[21:26]
    imm=bi_to_hex(bicode[16:32])
    mips=""
    
    if op=='000000':
        itype="R"
    elif op=='000010' or op=='000011':
        itype="J"
    else:
        itype="I"
    
    if itype=="J":
        if op=='000010':
            mips="j "
        elif op=='000011':
            mips="jal "
        linenum=int((int(str(int(bicode[6:32]+"00",2)))-12288)/4)
        if not linenum in label.keys():
            labelname="label_"+str(labelcount)
            out[linenum] = labelname+": "+out[linenum]
            if linenum > 0:
                out[linenum-1]+="\n"
            label[linenum]=labelcount
            labelcount += 1
            mips = mips+labelname
        else:
            labelname="label_"+str(label[linenum])
            mips = mips+labelname
            
    elif itype=="R":
        if bicode=='00000000000000000000000000000000':
            mips="nop"
        elif func=='100000':
            mips="add "+rd+", "+rs+", "+rt
        elif func=='100001':
            mips="addu "+rd+", "+rs+", "+rt
        elif func=='100100':
            mips="and "+rd+", "+rs+", "+rt
        elif func=='001101':
            mips="break"
        elif func=='011010':
            mips="div "+rs+", "+rt
        elif func=='011011':
            mips="divu "+rs+", "+rt
        elif func=='001001':
            mips="jalr "+rd+", "+rs
        elif func=='001000':
            mips="jr "+rs
        elif func=='010000':
            mips="mfhi "+rd
        elif func=='010010':
            mips="mflo "+rd
        elif func=='010001':
            mips="mthi "+rd
        elif func=='010011':
            mips="mtlo "+rd
        elif func=='011000':
            mips="mult "+rs+", "+rt
        elif func=='011001':
            mips="multu "+rs+", "+rt
        elif func=='100111':
            mips="nor "+rd+", "+rs+", "+rt 
        elif func=='100101':
            mips="or "+rd+", "+rs+", "+rt 
        elif func=='000000':
            mips="sll "+rd+", "+rt+", "+shamt
        elif func=='000100':
            mips="sllv "+rd+", "+rt+", "+rs
        elif func=='101010':
            mips="slt "+rd+", "+rs+", "+rt
        elif func=='101011':
            mips="sltu "+rd+", "+rs+", "+rt
        elif func=='000011':
            mips="sra "+rd+", "+rt+", "+shamt
        elif func=='000111':
            mips="srav "+rd+", "+rt+", "+rs
        elif func=='000010':
            mips="srl "+rd+", "+rt+", "+shamt
        elif func=='000110':
            mips="srlv "+rd+", "+rt+", "+rs
        elif func=='100010':
            mips="sub "+rd+", "+rs+", "+rt
        elif func=='100011':
            mips="subu "+rd+", "+rs+", "+rt
        elif func=='001100':
            mips="syscall"
        elif func=='100110':
            mips="xor "+rd+", "+rs+", "+rt
    
    elif itype=="I":
        if op=='001000':
            mips="addi "+rt+", "+rs+", "+imm
        elif op=='001001':
            mips="addiu "+rt+", "+rs+", "+imm
        elif op=='001100':
            mips="andi "+rt+", "+rs+", "+imm
        elif op=='000100':
            mips="beq "+rs+", "+rt+", "
        elif op=='000001' and bicode[11:16]=='00001':
            mips="bgez "+rs+", "
        elif op=='000111':
            mips="bgtz "+rs+", "
        elif op=='000110':
            mips="blez "+rs+", "
        elif op=='000001' and bicode[11:16]=='00000':
            mips="bltz "+rs+", "
        elif op=='000101':
            mips="bne "+rs+", "+rt+", "
        elif op=='010000' and func=='011000':
            mips="eret"
        elif op=='100000':
            mips="lb "+rt+", "+imm+"("+rs+")"
        elif op=='100100':
            mips="lbu "+rt+", "+imm+"("+rs+")"
        elif op=='100001':
            mips="lh "+rt+", "+imm+"("+rs+")"
        elif op=='100101':
            mips="lhu "+rt+", "+imm+"("+rs+")"
        elif op=='001111':
            mips="lui "+rt+", "+imm
        elif op=='100011':
            mips="lw "+rt+", "+imm+"("+rs+")"
        elif op=='010000' and bicode[6:11]=='00000':
            mips="mfc0 "+rt+", "+rd
        elif op=='010000' and bicode[6:11]=='00100':
            mips="mtc0 "+rt+", "+rd
        elif op=='001101':
            mips="ori "+rt+", "+rs+", "+imm
        elif op=='101000':
            mips="sb "+rt+", "+imm+"("+rs+")"
        elif op=='101001':
            mips="sh "+rt+", "+imm+"("+rs+")"
        elif op=='001010':
            mips="slti "+rt+", "+rs+", "+imm
        elif op=='001011':
            mips="sltiu "+rt+", "+rs+", "+imm
        elif op=='101011':
            mips="sw "+rt+", "+imm+"("+rs+")"
        elif op=='001110':
            mips="xori "+rt+", "+rs+", "+imm
        if mips[0]=='b':
            imm=bicode[16:32]
            immv=int(15*imm[0]+imm,2)
            if imm[0]=='1':
                immv=-immv
            linenum= int( (mipscount+1+immv)/4)
            if not linenum in label.keys():
                labelname="label_"+str(labelcount)
                try:
                    out[linenum] = labelname+": "+out[linenum]
                except:
                    pass
                if linenum > 0:
                    out[linenum-1]+="\n"
                label[linenum]=labelcount
                labelcount += 1
                mips = mips+labelname
            else:
                labelname="label_"+str(label[linenum])
                mips = mips+labelname
    mips+="\n"
    out[mipscount] += mips
    mipscount += 1
    
print("".join(out))
file_out.write("".join(out))
#print(out)
print("MIPS code has been written in out.txt")
time.sleep(5)
file_in.close()
file_out.close()
    
    
```



## 思考题

1. 上面我们介绍了通过 FSM 理解单周期 CPU 的基本方法。请大家指出单周期 CPU 所用到的模块中，哪些发挥状态存储功能，哪些发挥状态转移功能。

2. **现在我们的模块中 IM 使用 ROM， DM 使用 RAM， GRF 使用 Register，这种做法合理吗？ 请给出分析，若有改进意见也请一并给出。**

   * 合理。
   * 没有改进意见。

3. **在上述提示的模块之外，你是否在实际实现时设计了其他的模块？如果是的话，请给出介绍和设计的思路。**

   * 如教程所指出

     > 以“上游”为例，PC 寄存器对应 FSM 中的状态存储模块，判断下一个存入 PC 寄存器的值的电路（通常封装为 NPC 模块）对应 FSM 中的状态转移电路，而从 ROM 中取出指令并传给 splitter 的电路对应 FSM 中的输出电路。

   * 我设计了一个 `NPC` 模块。

   * 考虑到 PC 的更新方式有多种，我将其大致分为如下几类：

     1. 非跳转类：$\rm PC\leftarrow PC+4$
     2. 有条件跳转类（`beq`、`bneq`等）：$\rm PC\leftarrow PC+4+sign\_extend(Imm<<2)$
     3. 跳转到寄存器（`jr`）：$\rm PC\leftarrow GRF[rs]$
     4. 无条件跳转类（`j`）：~~指令集有点复杂，没太看懂~~

     于是，我引入一个控制信号 `NPCOp` 来判断是何种更新方式。其中第2种还要引入其他条件信号（如 `eq?`、`leg?`、`eqz?` 等）才能判断是否跳转。

     

4. 事实上，实现 `nop` 空指令，我们并不需要将它加入控制信号真值表，为什么？

1. 阅读 Pre 的 [“MIPS 指令集及汇编语言”](http://cscore.buaa.edu.cn/tutorial/mips/mips-6/mips6-1/) 一节中给出的测试样例，评价其强度（可从各个指令的覆盖情况，单一指令各种行为的覆盖情况等方面分析），并指出具体的不足之处。