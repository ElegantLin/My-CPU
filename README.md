# 54 CPU Instructions

This project is the final project of Computer Architecture and Structure, which is construct a 5 stage pipeline CPU of MIPS. The modules of this projects are:
* PC.v
* ALU.v


The instructions I have successfully constructed are:
1. ori rt, rs, immediate 
2. 


## Version 0.1

```
ori $1, $0, 0x1100		# $1 = $0 | 0x1100 = 0x1100
ori $2, $0, 0x0020		# $2 = $0 | 0x0020 = 0x0020
ori $3, $0, 0xff00		# $3 = $0 | 0xff00 = 0xff00
ori $4, $0, 0xffff		# $4 = $0 | 0xffff = 0xffff
```
![The simulation wave plot](http://i.imgur.com/Av5Cyab.png)

## Version 0.1.1

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

