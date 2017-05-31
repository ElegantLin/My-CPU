# 54 CPU Instructions

This project is the final project of Computer Architecture and Structure, which is construct a 5 stage pipeline CPU of MIPS. The modules of this projects are:
* PC.v
* ALU.v


The instructions I have successfully constructed are:
1. ori rt, rs, immediate 
2. 


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


The **6 shift operation** instructions are:
- sll
- sllv
- sra
- srav
- srl
- srlv

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

## Version 0.2.1
In this version, we are coming to the next version soon. The details are presented in the next version description.

## Version 0.3
In this version, we added another instructions in our instruction set.

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


