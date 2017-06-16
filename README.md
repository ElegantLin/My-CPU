# 54 Instructions 5-stage pipeline CPU

## Hint
For this course hasn't ended until the summer 2017. To prevent being copied by other lazy student, I will push it later. Thanks for your understanding.

## Course Info

This project is **Zonglin**'s final project of Computer Architecture and Structure of Tonji University, Shanghai, P.R.China,  whose class ID is **10101602** and its corresponding experiment ID is  **10012502**. These courses are given in the spring semester. Students can learn about the core of computer design in one semester through several projects and homework. Those who want to join this course are strongly recommended to have learned **Digital Logic** and **Verilog and FPGA Design**. The website of this course is mips246.tongji.edu.cn. The total credits of this course is **5.5**.

## Course Instructors
* Prof. Lisheng WANG
* Prof. Yongsheng CHEN
* Prof. Yongtao HAO
* Prof. Dongdong ZHNAG


## Structure of this project

* PC.v
* ALU.v

## My Instruction set
The instructions I have successfully constructed are:
1. ori rt, rs, immediate
2. and rd, rs, rt 

```
ori rt, rs, immediate => rt <- rs OR immediate
and rd, rs, rt => rd <- rs AND rt

```


## Version 0.1
This is the initial version of my CPU. I only finished the most simple ori instruction. And the plot is the simulation wave of the following MIPS code.

```
ori $1, $0, 0x1100		# $1 = $0 | 0x1100 = 0x1100
ori $2, $0, 0x0020		# $2 = $0 | 0x0020 = 0x0020
ori $3, $0, 0xff00		# $3 = $0 | 0xff00 = 0xff00
ori $4, $0, 0xffff		# $4 = $0 | 0xffff = 0xffff
```
![The simulation wave plot](http://i.imgur.com/Av5Cyab.png)

## Version 0.1.1
In this verison, I didn't add more instructions. I just corrected one bug. Try to consider the result of the following MIPS code. And we can get the simulation wave.

```
ori $1, $0, 0x1100		# $1 = $0 | 0x1100 = 0x1100
ori $1, $1, 0x0020		# $1 = $1 | 0x0020 = 0x1120
ori $1, $1, 0x4400		# $1 = $1 | 0x4400 = 0x5520
ori $1, $1, 0x0044		# $1 = $1 | 0x0044 = 0x5564
```

![](http://i.imgur.com/i3AbRoQ.png)

We can find the simulation plot is wrong because the $1 register will wait for several periods to write the real number back into the General Register Group. So we should handle this problem in this version. The solution is that We add several codes in the **id.v** file.

```
///Handle the problem at the executation process

input               ex_reg_write_en_i,
input[31:0]         ex_data_write_i,
input[4:0]          ex_addr_write_i,
   
///Handle the problem at the process from ALU to Memory

input               mem_reg_write_en_i,
input[31:0]         mem_data_write_i,
input[4:0]          mem_addr_write_i,
```

And we connect the corresponding modules together.

And the right simulation plot is 
![](http://i.imgur.com/l7Y1KKn.png)

## Version 0.2.0
In this version, we added more instructions to extent our quantity of instruction number to **14**. The **8 logical operation** instructions are:
* and
* andi
* or
* ori
* xor
* xori
* nor
* lui

I use the following code to check my CPU in this stage.

```
lui  $1, 0x0101				# $1 = 0x0101_0000
ori  $1, $1, 0x0101			# $1 = $1 | 0x0101 = 0x0101_0101
ori  $2, $1, 0x1100			# $2 = $1 | 0x1100 = 0x0101_1101
or   $2, $1, $2				# $1 = $1 | $2     = 0x0101_1101
andi $3, $1, 0x00fe			# $3 = $1 & 0x00fe = 0x0000_0000
and  $1, $3, $1				# $4 = $3 & $1 	   = 0x0000_0000
xori $4, $1, 0xff00			# $4 = $1 ^ 0xff00 = 0x0000_ff00
xor  $1, $4, $1				# $1 = $4 ^ $1	   = 0x0000_ff00
nor  $1, $4, $1				# $1 = $4 ~^ $1	   = 0xffff_00ff
```

The result is:
![](http://i.imgur.com/Rj0hpYR.png)

The **6 shift operation** instructions are:
- sll
- sllv
- sra
- srav
- srl
- srlv

I use the following code to check my CPU in this version.

```
lui	 $2, 0x0404				# $2 = 0x04040000
ori	 $2, $2, 0x4040			# $2 = 0x04040000 | 0x0404 = 0x04040404
ori	 $7, $0, 0x7			# $7 = 7
ori     $5, $0, 0x5			# $5 = 5
ori     $8, $0, 0x8			# $8 = 8
sync
sll     $2, $2, 8				# $2 = 0x40404040 sll 8 = 0x04040400
sllv    $2, $2, $7				# $2 = 0x04040400 sll 7 = 0x02020000
srl     $2, $2, 8				# $2 = 0x02020000 srl 8 = 0x00020200
srlv    $2, $2, $5				# $2 = 0x00020200 srl 5 = 0x00001010
nop
pref
sll     $2, $2, 19				# $2 = 0x00001010 sll 19 =0x80800000
ssnop
sra     $2, $2, 16				# $2 = 0x80800000 sra 16 =0xffff8080
srav    $2, $2, $8				# $2 = 0xffff8080 sra 8 = 0xffffff80
``` 

And the wave is as follows:
![](http://i.imgur.com/mW1nfga.png)

## Version 0.2.1
In this version, we are coming to the next version soon. The details are presented in the next version description.

## Version 0.3
In this version, we added some **move** instructions in our instruction set. They are

* movn
* movz
* mthi
* mtlo
* mfhi
* mflo

We use the following codes to check our instruction.

```
lui $1, 0x0000			# $1 = 0x0000_0000
lui $2, 0xffff			# $2 = 0xffff_0000
lui $3, 0x0505			# $3 = 0x0505_0000
lui $4, 0x0000			# $4 = 0x0000_0000

movz $4, $2, $1			# $4 = 0xffff_0000
movn $4, $3, $1			# $4 = 0xffff_0000
movz $4, $3, $2			# $4 = 0x0505_0000

mthi $0				# hi = 0x0000_0000
mthi $2 			# h1 = 0xffff_0000
mthi $3				# hi = 0x0505_0000

mfhi $4				# $4 = 0x0505_0000

mtlo $3				# lo = 0x0505_0000
mtlo $2				# lo = 0xffff_0000
mtlo $1				# lo = 0x0000_0000

mflo $4				# $4 = 0x0000_0000
```

The simulation wave is
![](http://i.imgur.com/e1N38Lu.png)

## Version 0.4
In this version, we added another several calculation instructions into our instruction set.They are:

* add
* addu
* sub
* subu
* addi
* addiu
* slt
* sltu
* sltiu
* clo
* clz
* mul
* mult
* multu

We used the following instruction to test the CPU

```
ori 	$1, $0, 0x8000				# $1 = 0x0000_8000
sll 	$1, $1, 16					# $1 = 0x8000_0000
ori 	$1, $1, 0x0010				# $1 = 0x8000_0010

ori     $2, $0, 0x8000				# $2 = 0x0000_8000
sll     $2, $2, 16					# $2 = 0x8000_0000
ori     $2, $2, 0x0001				# $2 = 0x8000_0001

ori     $3, $0, 0x0000				# $3 = 0x0000_0000
addu	$3, $2, $1					# $3 = 0x0000_0011
ori	 $3, $0, 0x0000				# $3 = 0x0000_0000
add	 $3, $2, $1					# $3 = 0x0000_0000 (overflow_flag = 1)

sub 	$3, $1, $3					# $3 = 0x8000_0010
subu	$3, $3, $2					# $3 = 0x0000_000f

addi	$3, $3, 2					# $3 = 0x0000_0011
ori 	$3, $0, 0x0000				# $3 = 0x0000_0000
addiu   $3, $3, 0x8000				# $3 = 0xffff_8000

or 	 $1, $0, 0xffff				# $1 = 0x0000_ffff
sll	 $1, $1, 16					# $1 = 0xffff_0000
slt	 $2, $1, $0					# $2 = 1
sltu	$2, $1, $0					# $2 = 0
slti	$2, $1, 0x8000				# $2 = 1
sltiu   $2, $1, 0x8000				# $2 = 1

lui	 $1, 0x0000					# $1 = 0x0000_0000
clo	 $2, $1						# $2 = 0x0000_0000
clz	 $2, $1						# $2 = 0x0000_0020

lui	 $1, 0xffff					# $1 = 0xffff_0000
ori	 $1, $1, 0xffff				# $1 = 0xffff_ffff
clz	 $2, $1						# $2 = 0x0000_0000
clo	 $2, $1						# $2 = 0x0000_0020

lui	 $1, 0xa100					# $1 = 0xa100_0000
clz	 $2, $1						# $2 = 0x0000_0000
clo	 $2, $1						# $2 = 0x0000_0001

lui	 $1, 0x1100					# $1 = 0x1100_0000
clz	 $2, $1						# $2 = 0x0000_0003
clo	 $2, $1						# $2 = 0x0000_0000

ori	 $1, $0, 0xffff
sll	 $1, $1, 16
ori	 $1, $1, 0xfffb				# $1 = -5
ori	 $2, $0, 6					# $2 = 6
mul	 $3, $1, $2					# $3 = -30 = 0xffff_ffe2

mult	$1, $2						# HI = 0xffff_ffff
									# LO = 0xffff_ffe2

multu   $1, $2						# HI = 0x5
									# LO = 0xffff_ffe2
nop
nop
```

The simulation wave is
![](http://i.imgur.com/GsGH9wW.png)


## Version 0.5
In this version, I successfully added 4 instructions into my instruction set and I completed the pause method in CPU, which is useful in **DIVIDE** especially.

* MADD
* MADDU
* MSUB
* MSUBU

The testing codes are:

```
   ori  $1,$0,0xffff                  
   sll  $1,$1,16
   ori  $1,$1,0xfffb           # $1 = -5
   ori  $2,$0,6                # $2 = 6

   mult $1,$2                  # hi = 0xffffffff
                               # lo = 0xffffffe2

   madd $1,$2                  # hi = 0xffffffff
                               # lo = 0xffffffc4

   maddu $1,$2                 # hi = 0x5
                               # lo = 0xffffffa6

   msub $1,$2                  # hi = 0x5
                               # lo = 0xffffffc4   

   msubu $1,$2                 # hi = 0xffffffff
                               # lo = 0xffffffe2 

```

The simulation wave is 
![](http://i.imgur.com/e4QYTb1.png)

## Version0.6
I have successfully finished the **jump** instructions
The simulation wave is
![](http://i.imgur.com/Q6TCkhp.png)


## Acknowledgment
* Vivado and Verilog: **Zijian WANG** (CS Junior from Tongji University)
* Vivado and Top Test Module: **Hongwei ZHANG** (CS Junior from Tongji University)
* Exception Instruction Handling: **Kun 5** (CS Junior from Tongji University)
* **Silei LEI**,  *Write CPU By Yourself 1st version* 



*June 16, 2017 in Tongji University*

