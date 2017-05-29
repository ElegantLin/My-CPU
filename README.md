#54 CPU Instructions

This project is the final project of Computer Architecture and Structure, which is construct a 5 stage pipeline CPU of MIPS. The modules of this projects are:
* PC.v

The instructions I have successfully constructed are:
1. ori rt, rs, immediate 
2. 


##Version 0.1

```
ori $1, $0, 0x1100		# $1 = $0 | 0x1100 = 0x1100
ori $2, $0, 0x0020		# $2 = $0 | 0x0020 = 0x0020
ori $3, $0, 0xff00		# $3 = $0 | 0xff00 = 0xff00
ori $4, $0, 0xffff		# $4 = $0 | 0xffff = 0xffff
```
![The simulation wave plot](http://i.imgur.com/Av5Cyab.png)