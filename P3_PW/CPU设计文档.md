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

   | 指令  | RTL描述的操作过程                                     |
   | ----- | ----------------------------------------------------- |
   | `add` | $\rm R[rd] \leftarrow R[rs]+R[rt]$                    |
   | `sub` | $\rm R[rd]\leftarrow R[rs]-R[rt]$                     |
   | `ori` | $\rm R[rt]\leftarrow R[rs]\; OR\;zero\_extend(imm16)$ |
   | `lui` | $\rm R[rt]\leftarrow 高位\_extend(imm16)$             |

2. 访存类

   | 指令 | RTL描述的操作过程                                            |
   | ---- | ------------------------------------------------------------ |
   | `lw` | $\rm Addr \leftarrow R[rs] + sign\_extend(imm16)$ <br>$\rm R[rt] \leftarrow Mem[Addr]$ |
   | `sw` | $\rm Addr \leftarrow R[rs] + sign\_extend(imm16)$ <br/>$\rm Mem[Addr] \leftarrow R[rt]$ |

3. 跳转类

   | 指令  | RTL描述的操作过程                                            |
   | ----- | :----------------------------------------------------------- |
   | `beq` | $\rm PC \leftarrow (R[rs]==R[rt])\,?\,PC+4+sign\_extend(imm16<<2):PC+4$ |

将RTL描述放在一起提取 **共性** 之后，可以发现，excute的部分无非就是：ALU运算、写入到寄存器、写入到DM。而决定每条指令 **个性** 的就是一些控制信号。

## 控制信号分析

仔细辨别各指令共性下的个性后，设计控制信号若干如下：

* NPC模块的 `NPCOp` 控制信号，控制：

  * 简单的PC+4
  * 有条件跳转`beq`、`blt`……

  （是待以下扩展的）

  * 无条件跳转`j`、`jal`（与`j`相比，需要回写$\rm R[31]=PC+4$）
  * 跳转到寄存器`jr`
  * ……

* EXT模块的 `EXTOp` 控制信号，控制：

  * 00：zero extend
  * 01：sign extend
  * 10：加载到高位（`lui`）
  * 11：……

* 写入寄存器的**来源数据**控制信号 `RegSrc`，控制：

  * 00：ALU的res
  * 01：DM的MemRD
  * 10：EXT的extend(imm)
  * 11：……

* 写入寄存器的**目的地址**控制信号 `RegDst`，控制：

  * 00：rt
  * 01：rd
  * 10：……
  * 11：……

* 写入寄存器的使能信号 `RegWrite`

  * 0

  * 1

* ALU模块的B端信号的来源控制信号 `ALUSrc`，控制：

  * 0：GRF的RegRD2
  * 1：EXT的extend(imm)

* ALU模块的运算符控制信号 `ALUOp`

  * 00：加
  * 01：减
  * 10：或
  * 11：……

* 写入DM模块的使能信号 `MemWrite`


> 基本上每个控制信号，我都多留1-2个空位，方便课上扩展。









## 关键模块构造

### 1. IFU

#### 端口定义

| 信号名称    | 方向 | 描述                 |
| ----------- | ---- | -------------------- |
| NPC[31:0]   | I    | 下一个PC值           |
| rst         | I    | 异步复位信号         |
| clk         | I    | 时钟信号             |
| PC[31:0]    | O    | 当前PC值             |
| Instr[31:0] | O    | 当前PC指向的32位指令 |

#### 功能定义

| 序号 | 功能 | 描述                                               |
| ---- | ---- | -------------------------------------------------- |
| 1    | 复位 | 当异步复位有效时，将当前PC值复位为0x00003000       |
| 2    | 取指 | 当时钟上升沿到来时，更新PC值，并取出PC值指向的指令 |

### 2. NPC

#### 端口定义

| 信号名称         | 方向 | 描述                                                         |
| ---------------- | ---- | ------------------------------------------------------------ |
| PC[31:0]         | I    | 当前PC值                                                     |
| NPCOp[1:0]       | I    | 控制PC更新的方式，具体见功能定义<br>00：顺序更新<br>01：beq更新<br>10：……<br>11：…… |
| Extend_Imm[31:0] | I    | EXT模块输出端的立即数                                        |
| Imm26[25:0]      | I    | j型跳转指令的地址，来自指令的25:0位                          |
| $reg[31:0]       | I    | GRF模块读出的某个寄存器的值                                  |
| eq?              | I    | ALU模块输出端的`R[rs]==R[rt]`判断结果<br>0：不相等<br>1：相等 |
| NPC[31:0]        | O    | 下一个PC值                                                   |
| PC+4[31:0]       | O    | 当前PC值+4                                                   |

#### 功能定义

| 序号 | 功能     | 描述                                                |
| ---- | -------- | --------------------------------------------------- |
| 1    | 顺序更新 | PC ← PC + 4                                         |
| 2    | beq更新  | PC ← (R[rs] == R[rt]) ? PC + 4 +sign_extend(imm<<2) |
| 3    | ……       | ……                                                  |
| 4    | ……       | ……                                                  |

### 3. GRF

#### 端口定义

| 信号名称     | 方向 | 描述                    |
| ------------ | ---- | ----------------------- |
| A1[4:0]      | I    | 5位读寄存器地址（编号） |
| A2[4:0]      | I    | 5位读寄存器地址（编号） |
| A3[4:0]      | I    | 5位写寄存器地址（编号） |
| WD[31:0]     | I    | 32位写入数据            |
| WE           | I    | 写使能信号              |
| rst          | I    | 异步复位信号            |
| clk          | I    | 时钟信号                |
| RegRD1[31:0] | O    | A1寄存器读出值          |
| RegRD2[31:0] | O    | A2寄存器读出值          |

#### 功能定义

| 序号 | 功能   | 描述                                                         |
| ---- | ------ | ------------------------------------------------------------ |
| 1    | 复位   | 当异步复位有效时，将所有寄存器的值复位为0                    |
| 2    | 读数据 | 从RegRD1、RegRD2端口读出A1、A2寄存器的值                     |
| 3    | 写数据 | 当 **<font color =orange>时钟上升沿到来</font>，且<font color=cyan>使能信号WE有效</font>**时，将WD写入到A3寄存器 |

### 4. ALU

#### 端口定义

| 信号名称   | 方向 | 描述                                                         |
| ---------- | ---- | ------------------------------------------------------------ |
| A[31:0]    | I    | 参与运算的第一个数                                           |
| B[31:0]    | I    | 参与运算的第二个数                                           |
| ALUOp[1:0] | I    | 控制运算的方法，具体见功能定义<br>00：算术加法<br>01：算术减法<br>10：逻辑或运算<br>11：…… |
| eq?        | O    | 输出 (A == B) ? 1 : 0                                        |
| res[31:0]  | O    | 运算结果                                                     |

#### 功能定义

| 序号 | 功能       | 描述         |
| ---- | ---------- | ------------ |
| 1    | 算术加法   | res = A + B  |
| 2    | 算术减法   | res = A - B  |
| 3    | 逻辑或运算 | res = A OR B |
| 4    | ……         | ……           |

### 5. EXT

#### 端口定义

| 信号名称         | 方向 | 描述                                                         |
| ---------------- | ---- | ------------------------------------------------------------ |
| Imm[15:0]        | I    | 待扩展的16位立即数，来自I型指令的15:0位                      |
| EXTOp[1:0]       | I    | 控制立即数的扩展方式，具体见功能定义：<br>00：无符号扩展<br>01：符合扩展<br>10：加载到高位<br>11：…… |
| Extend_Imm[31:0] | O    | 扩展后的32位立即数                                           |

#### 功能定义

| 序号 | 功能                      | 描述                                     |
| ---- | ------------------------- | ---------------------------------------- |
| 1    | 无符号扩展（zero extend） | 高位补0                                  |
| 2    | 符合扩展（sign extend）   | 符合位为0，高位补0<br>符号位为1，高位补1 |
| 3    | 加载到高位（lui）         | Imm加载到高16位，低16位补0               |
| 4    | ……                        | ……                                       |

### 6. DM

#### 端口定义

| 信号名称      | 方向 | 描述                              |
| ------------- | ---- | --------------------------------- |
| MemAddr[31:0] | I    | 待写入数据/读出数据在内存中的地址 |
| MemData[31:0] | I    | 待写入内存的数据                  |
| MemWrite      | I    | 写使能信号                        |
| rst           | I    | 异步复位信号                      |
| clk           | I    | 时钟信号                          |
| MemRD[31:0]   | O    | 读出的数据                        |

#### 功能定义

| 序号 | 功能     | 描述                                                         |
| ---- | -------- | ------------------------------------------------------------ |
| 1    | 异步复位 | 当异步复位信号有效时，将内存中的数据全部都复位为0            |
| 2    | 读数据   | 从MemRD端口读出内存中地址为MemAddr的数据                     |
| 3    | 写数据   | 当 **<font color =orange>时钟上升沿到来</font>，且<font color=cyan>使能信号MemWrite有效</font>**时，将MemData写入到内存中地址为MemAddr的位置 |
| 4    | ……       | ……                                                           |

### 7. Ctrl

#### 端口定义

| 信号名称    | 方向 | 描述                                                         |
| ----------- | ---- | ------------------------------------------------------------ |
| op[5:0]     | I    | 所有指令的操作码，来自指令的31:26位                          |
| funct[5:0]  | I    | R型指令的辅助识别码，来自R型指令的5:0为                      |
| RegDst[1:0] | O    | 控制哪个寄存器写入数据：<br>00：Rt<br>01：Rd<br>10：……<br>11：…… |
| RegSrc[1:0] | O    | 控制寄存器写入哪里的数据：<br>00：ALU的运算结果（如`add`、`sub`、`ori`）<br>01：DM的读出数据（如`lw`）<br>10：EXT扩展后的立即数（如`lui`）<br>11：…… |
| RegWrite    | O    | 控制GRF的写使能端何时有效：<br>0：GRF的写使能端无效<br>1：GRF的写使能端有效 |
| EXTOp[1:0]  | O    | 控制16位立即数采取何种方式扩展：<br>00：无符号扩展<br>01：符合扩展<br>10：加载到高位<br>11：…… |
| ALUSrc      | O    | 控制ALU的B端数据来自哪里：<br>0：GRF的RD2端读出数据<br>1：EXT扩展后的立即数 |
| ALUOp[1:0]  | O    | 控制ALU采取何种算术/逻辑运算：<br>00：算术加法<br>01：算术减法<br>10：逻辑或<br>11：…… |
| NPCOp[1:0]  | O    | 控制PC采取何种方式更新：<br>00：顺序更新<br>01：beq          |

#### 控制信号真值表

|           |       | R      | add    | sub    | ori    | lui    | beq    | lw     | sw     |
| --------- | ----- | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ |
|           | op    | 000000 |        |        | 001101 | 001111 | 000100 | 100011 | 101011 |
|           | funct |        | 100000 | 100010 |        |        |        |        |        |
| RegDst[1] |       |        | 0      | 0      | 0      | 0      |        | 0      |        |
| RegDst[0] |       |        | 1      | 1      | 0      | 0      |        | 0      |        |
| RegSrc[1] |       |        | 0      | 0      | 0      | 1      |        | 0      |        |
| RegSrc[0] |       |        | 0      | 0      | 0      | 0      |        | 1      |        |
| RegWrite  |       |        | 1      | 1      | 1      | 1      |        | 1      |        |
| EXTOp[1]  |       |        |        |        | 0      | 1      | 0      | 0      | 0      |
| EXTOp[0]  |       |        |        |        | 0      | 0      | 1      | 1      | 1      |
| ALUSrc    |       |        | 0      | 0      | 1      |        | **0**  | 1      | 1      |
| ALUOp[1]  |       |        | 0      | 0      | 1      |        |        |        |        |
| ALUOp[0]  |       |        | 0      | 1      | 0      |        |        |        |        |
| NPCOp[1]  |       |        |        |        |        |        | 0      |        |        |
| NPCOp[0]  |       |        |        |        |        |        | 1      |        |        |
|           |       |        |        |        |        |        |        |        |        |

> 可以发现，前5行要考虑的都是同一些指令，即需要写入到寄存器的那些指令

> `beq` 虽然有立即数，是I型指令，但是ALU运算的两个数据都来自寄存器（Rs和Rt），对应ALUSrc=0

> 控制信号基本都预留1-2个空位，方便课上扩展

## 测试

### 1. 运算类指令测试

测试 `ori` 指令和GRF阵列。

通过Python程序生成指令

```python
for i in range(32):
    print("ori ${},$zero,0x{:0>2d}{:0>2d}".format(i,i,i))
```

指令：

```assembly
ori $0,$zero,0x0000
ori $1,$zero,0x0101
ori $2,$zero,0x0202
ori $3,$zero,0x0303
ori $4,$zero,0x0404
ori $5,$zero,0x0505
ori $6,$zero,0x0606
ori $7,$zero,0x0707
ori $8,$zero,0x0808
ori $9,$zero,0x0909
ori $10,$zero,0x1010
ori $11,$zero,0x1111
ori $12,$zero,0x1212
ori $13,$zero,0x1313
ori $14,$zero,0x1414
ori $15,$zero,0x1515
ori $16,$zero,0x1616
ori $17,$zero,0x1717
ori $18,$zero,0x1818
ori $19,$zero,0x1919
ori $20,$zero,0x2020
ori $21,$zero,0x2121
ori $22,$zero,0x2222
ori $23,$zero,0x2323
ori $24,$zero,0x2424
ori $25,$zero,0x2525
ori $26,$zero,0x2626
ori $27,$zero,0x2727
ori $28,$zero,0x2828
ori $29,$zero,0x2929
ori $30,$zero,0x3030
ori $31,$zero,0x3131
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

指令：

```assembly
ori $1,$0,1
add $2,$1,$1
add $3,$2,$2
add $4,$3,$3
add $5,$4,$4
add $6,$5,$5
add $7,$6,$6
add $8,$7,$7
add $9,$8,$8
add $10,$9,$9
add $11,$10,$10
add $12,$11,$11
add $13,$12,$12
add $14,$13,$13
add $15,$14,$14
add $16,$15,$15
add $17,$16,$16
add $18,$17,$17
sub $19,$18,$17
sub $20,$19,$18
sub $21,$20,$19
sub $22,$21,$20
sub $23,$22,$21
sub $24,$23,$22
sub $25,$24,$23
sub $26,$25,$24
sub $27,$26,$25
sub $28,$27,$26
sub $29,$28,$27
sub $30,$29,$28
sub $31,$30,$29
```

MARS结果：

![image-20231026215937958](C:\Users\Arren\AppData\Roaming\Typora\typora-user-images\image-20231026215937958.png)

CPU结果：

![image-20231026220456064](C:\Users\Arren\AppData\Roaming\Typora\typora-user-images\image-20231026220456064.png)

### 2. 访存类指令测试

指令：

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

### 3. 跳转类指令测试

指令：

```assembly
ori $1,$0,0x1234
add $2,$1,$0

ori $9,$9,0x1230
sub $10,$1,$9
add $10,$10,$10
add $10,$10,$10

lui $1,0x1234

ori $31,$0,0xffff

sw $31,0($10)

sub $31,$31,$1



beq $1,$2,yes1
	sw $31,-4($10)
	sw $31,-8($10)
	sw $31,-12($10)
yes1:
	sw $31,-16($10)
	
lui $2,0x1234
beq $1,$2,yes2
	sw $31,4($10)
	sw $31,8($10)
	sw $31,12($10)
	sw $31,16($10)
yes2:
	sw $31,24($10)
	
ori $20,$0,0
ori $21,$0,1
back:
	add $21,$21,$21
	sub $2,$2,$21
	
	
	beq $1,$2,back
```

MARS结果：

![image-20231026224706558](C:\Users\Arren\AppData\Roaming\Typora\typora-user-images\image-20231026224706558.png)



![image-20231026224718943](C:\Users\Arren\AppData\Roaming\Typora\typora-user-images\image-20231026224718943.png)



CPU结果：

![image-20231026225300029](C:\Users\Arren\AppData\Roaming\Typora\typora-user-images\image-20231026225300029.png)

![image-20231026225330314](C:\Users\Arren\AppData\Roaming\Typora\typora-user-images\image-20231026225330314.png)

### 4. 压力测试

通过下面的Python程序生成仅一千条指令，对  *除`beq`以外（~~因为太菜了，不会写~~）*   的指令进行压力测试：

```Python
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
```

由于数据随机性强，MARS容易出现异常中断，我将MARS中的add（sub）都替换为addu（subu），再与CPU的结果进行对比。

结果初步吻合。

## 思考题

1. **上面我们介绍了通过 FSM 理解单周期 CPU 的基本方法。请大家指出单周期 CPU 所用到的模块中，哪些发挥状态存储功能，哪些发挥状态转移功能。**

   * 状态存储：IM、GRF、DM
   * 状态转移：NPC，ALU

2. **现在我们的模块中 IM 使用 ROM， DM 使用 RAM， GRF 使用 Register，这种做法合理吗？ 请给出分析，若有改进意见也请一并给出。**

   * 合理。
   * 没有改进意见。

3. **在上述提示的模块之外，你是否在实际实现时设计了其他的模块？如果是的话，请给出介绍和设计的思路。**

   * 我另外设计了一个 `NPC` 模块。

   * 功能介绍见《关键模块构造》部分。

   * 设计思路：

     ①从Ctrl引出ALUOp 

     ②从ALU引出`R[rs]==R[rd]`的结果；

     引入到NPC判断是非跳转类还是beq跳转。

     同时考虑到课上扩展，我将可能出现的PC更新方式作大致分类，罗列如下：

     * **<font color=orange>非跳转类</font>**：$\rm PC\leftarrow PC+4$
     * **<font color=orange>b 跳转类</font>**：$\rm PC\leftarrow (R[rs]==R[rt])\,?PC+4+sign\_extend(Imm||0^2):PC+4$
       * `beq`
       * `beqz`
       * `blt`
       * ……
     * **<font color=orange>j 跳转类</font>**：$\rm PC\leftarrow PC_{31..28}||Imm_{25..0}||0^2$
       * `j`
       * `jal`：还需要回写R[31]←PC+4
     * **<font color=orange>jr跳转类</font>**：$\rm PC\leftarrow R[rs]$
       * `jr`
       * `jalr`

4. **事实上，实现 `nop` 空指令，我们并不需要将它加入控制信号真值表，为什么？**

   * nop各为全为0，因此产生控制信号也全为0
     * NOPOp为0，不会跳转
     * RegWrite，不会改变寄存器堆
     * MemWrite，不会改变内存
   * 综上，nop不会对CPU造成影响

5. **阅读 Pre 的 [“MIPS 指令集及汇编语言”](http://cscore.buaa.edu.cn/tutorial/mips/mips-6/mips6-1/) 一节中给出的测试样例，评价其强度（可从各个指令的覆盖情况，单一指令各种行为的覆盖情况等方面分析），并指出具体的不足之处。**

   * 寄存器覆盖较少
   * `beq`测试时，没有测试offset为负数的情况，测试不够充分
   * ……