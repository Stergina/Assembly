#-----------------------------------------------------------------------------------------------------
# Author: Stergina
#-----------------------------------------------------------------------------------------------------

#-----------------------------------------------------------------------------------------------------
# Code section - commands 
#-----------------------------------------------------------------------------------------------------
	.text

main:
	la $a0, menu	#print the menu
	li $v0, 4
	syscall

	li $v0, 5	#load appropriate system call code into register $v0 in order to read integer
	syscall		#call operating system to perform operation

	beq $v0, 0, exit		#branch to exit if $v0 = 0
	beq $v0, 1, readArrayA		#branch to readArrayA if $v0 = 1
	beq $v0, 2, readArrayB		#branch to readArrayB if $v0 = 2
	beq $v0, 3, createSparseA	#branch to createSparseA if $v0 = 3
	beq $v0, 4, createSparseB	#branch to createSparseB if $v0 = 4
	beq $v0, 5, createSparseC	#branch to createSparseC if $v0 = 5
	beq $v0, 6, printSparseA	#branch to printSparseA if $v0 = 6
	beq $v0, 7, printSparseB	#branch to printSparseB if $v0 = 7
	beq $v0, 8, printSparseC	#branch to printSparseC if $v0 = 8

exit:
	li $v0, 10	#terminate program run and
	syscall		#exit


readArrayA:
	la $a0, blank	#print blank line
	li $v0, 4
	syscall

	la $a0, enterA	#print the message indicating to enter values to be stored in arrayA
	li $v0, 4
	syscall

	li $t0, 0	#load i = 0 into register $t0
	li $s0, 0	#register $s0 used to store the size of arrayA

L1:
	bge $s0, 10, done	#branch to done if $s0 >= 10

	la $a0, pos	#print message indicating the position in arrayA
	li $v0, 4
	syscall

	li $v0, 1	#load appropriate system call code into register $v0 in order to print integer
	move $a0, $s0	#move integer to be printed into $a0 
	syscall		#call operating system to perform operation

	la $a0, mark	#print message mark
	li $v0, 4 
	syscall

	bge $t0, 40, done	#branch to done if $t0 >= 40
	li $v0, 5		#load appropriate system call code into register $v0 in order to read integer
	syscall			#call operating system to perform operation

	addi $s0, $s0, 1	#increase value stored in register $s0 by 1
	sw $v0, arrayA($t0)	#store word in register $v0 contained in arrayA($t0)
	addi $t0, $t0, 4	#increase value stored in register $t0 by 4
	j L1			#go to subroutine L1


readArrayB:
	la $a0, blank	#print a blank line
	li $v0, 4
	syscall

	la $a0, enterB	#print the message indicating to enter values to be stored in arrayB
	li $v0, 4
	syscall

	li $t0, 0	#load i = 0 into register $t0
	li $s1, 0	#register $s1 used to store the size of arrayB

L2:
	bge $s1, 10, done	#branch to done if $s1 >= 10

	la $a0, pos	#print message indicating the position in arrayB
	li $v0, 4
	syscall

	li $v0, 1	#load appropriate system call code into register $v0 in order to print integer
	move $a0, $s1 	#move integer to be printed into $a0
	syscall		#call operating system to perform operation

	la $a0, mark	#print message mark
	li $v0, 4
	syscall

	bge $t0, 40, done	#branch to done if $t0 >= 40
	li $v0, 5		#load appropriate system call code into register $v0 in order to read integer
	syscall			#call operating system to perform operation

	addi $s1, $s1, 1	#increase value stored in register $s1 by 1 
	sw $v0, arrayB($t0)	#store word in register $v0 contained in arrayB($t0)
	addi $t0, $t0, 4	#increase value stored in register $t0 by 4
	j L2			#go to subroutine L2


createSparseA:
	la $t0, arrayA	#copy RAM address of arrayA into register $t0
	la $t1, ($s0)	#copy the size of arrayA into register $t1
	li $t2, 0	#load i = 0 into register $t2
	li $t3, 0	#load k = 0 into register $t3
	li $s2, 0	#register $s2 used to store the size of sparseA

L3:
	bge $t2, $t1, done	#branch to done if $t2 >= $t1
	lw $t4, ($t0)		#load word at RAM address contained in $t0 into register $t4
	bne $t4, 0, L4		#branch to L4 if  $t4 <> 0
	beq $t4, 0, L5		#branch to L5 if  $t4 = 0

L4: 
	sw $t2, sparseA($t3)	#store word in sparseA($t3) contained in register $t2
	addi $t3, $t3, 4	#increase value stored in register $t3 by 4
	sw $t4, sparseA($t3)	#store word in sparseA($t3) contained in register $t4
	addi $t3, $t3, 4	#increase value stored in register $t3 by 4

	addi $s2, $s2, 2	#increase value stored in register $s2 by 2
	addi $t0, $t0, 4	#increase value stored in register $t0 by 4
	addi $t2, $t2, 1	#increase value stored in register $t2 by 1
	j L3			#go to subroutine L3

L5:
	addi $t0, $t0, 4	#increase value stored in register $t0 by 4
	addi $t2, $t2, 1	#increase value stored in register $t2 by 1
	j L3			#go to subroutine L3


createSparseB:
	la $t0, arrayB	#copy RAM address of arrayB into register $t0  
	la $t1, ($s1)	#copy the size of arrayB into register $t1
	li $t2, 0	#load i = 0 into register $t2
	li $t3, 0	#load k = 0 into register $t3
	li $s3, 0	#register $s3 used to store the size of sparseB

L6:
	bge $t2, $t1, done	#branch to done if $t2 >= $t1
	lw $t4, ($t0)		#load word at RAM address contained in $t0 into register $t4
	bne $t4, 0, L7		#branch to L7 if  $t4 <> 0
	beq $t4, 0, L8		#branch to L8 if  $t4 = 0

L7: 
	sw $t2, sparseB($t3)	#store word in sparseB($t3) contained in register $t2
	addi $t3, $t3, 4	#increase value stored in register $t3 by 4
	sw $t4, sparseB($t3)	#store word in sparseB($t3) contained in register $t4
	addi $t3, $t3, 4	#increase value stored in register $t3 by 4

	addi $s3, $s3, 2	#increase value stored in register $s3 by 2
	addi $t0, $t0, 4	#increase value stored in register $t0 by 4
	addi $t2, $t2, 1	#increase value stored in register $t2 by 1
	j L6			#go to subroutine L6

L8:
	addi $t0, $t0, 4	#increase value stored in register $t0 by 4
	addi $t2, $t2, 1	#increase value stored in register $t2 by 1
	j L6			#go to subroutine L6


createSparseC:
	la $t0, sparseA	#copy RAM address of sparseA into register $t0
	la $t1, ($s2)	#copy the size of sparseA into register $t1

	la $t2, sparseB	#copy RAM address of sparseB into register $t2
	la $t3, ($s3)	#copy the size of sparseB into register $t3

	li $t4, 0	#load counter = 0 into register $t4
	li $t5, 0	#load a = 0 into register $t5
	li $t6, 0	#load b = 0 into register $t6
	li $s4, 0	#load c = 0 into register $s4 (used to store size of sparceC)

L9:
	bge $t5, $t1, L14	#branch to L14 if $t5 >= $t1
	bge $t6, $t3, L15	#branch to L14 if $t6 >= $t3
	j L10			#go to subroutine L10

L10:
	lw $t7, ($t0)		#load word at RAM address contained in $t0 into register $t7
	lw $t8, ($t2)		#load word at RAM address contained in $t2 into register $t8
	blt $t7, $t8, L11	#branch to L11 if  $t7 < $t8
	bgt $t7, $t8, L12	#branch to L12 if  $t7 > $t8
	beq $t7, $t8, L13	#branch to L13 if  $t7 = $t8

L11:
	sw $t7, sparseC($t4)	#store word in sparseC($t4) contained in register $t7 
	addi $t4, $t4, 4	#increase value stored in register $t4 by 4
	addi $t0, $t0, 4	#increase value stored in register $t0 by 4

	lw $t7, ($t0)		#load word at RAM address contained in $t0 into register $t7
	sw $t7, sparseC($t4)	#store word in sparseC($t4) contained in register $t7
	addi $t4, $t4, 4	#increase value stored in register $t4 by 4
	addi $t0, $t0, 4	#increase value stored in register $t0 by 4

	addi $s4, $s4, 2	#increase value stored in register $s4 by 2
	addi $t5, $t5, 2	#increase value stored in register $t5 by 2
	j L9			#go to subroutine L9

L12:
	sw $t8, sparseC($t4)	#store word in sparseC($t4) contained in register $t8
	addi $t4, $t4, 4	#increase value stored in register $t4 by 4
	addi $t2, $t2, 4	#increase value stored in register $t2 by 4

	lw $t8, ($t2)		#load word at RAM address contained in $t2 into register $t8
	sw $t8, sparseC($t4)	#store word in sparseC($t4) contained in register $t8
	addi $t4, $t4, 4	#isncrease value stored in register $t4 by 4
	addi $t2, $t2, 4	#increase value stored in register $t2 by 4

	addi $s4, $s4, 2	#increase value stored in register $s4 by 2
	addi $t6, $t6, 2	#increase value stored in register $t6 by 2
	j L9			#go to subroutine L9

L13:
	sw $t7, sparseC($t4)	#store word in sparseC($t4) contained in register $t7
	addi $t4, $t4, 4	#increase value stored in register $t4 by 4
	addi $t0, $t0, 4	#increase value stored in register $t0 by 4
	addi $t2, $t2, 4	#increase value stored in register $t2 by 4

	lw $t7, ($t0)		#load word at RAM address contained in $t0 into register $t7
	lw $t8, ($t2)		#load word at RAM address contained in $t2 into register $t8
	add $t9, $t7, $t8 	#add the values stored in registers $t7 and $t8 and store them in register $t9	
	sw $t9, sparseC($t4)	#store word in sparseC($t4) contained in register $t9
	addi $t4, $t4, 4	#increase value stored in register $t4 by 4
	addi $t0, $t0, 4	#increase value stored in register $t0 by 4
	addi $t2, $t2, 4	#increase value stored in register $t2 by 4

	addi $t5, $t5, 2	#increase value stored in register $t5 by 2
	addi $t6, $t6, 2	#increase value stored in register $t6 by 2
	addi $s4, $s4, 2	#increase value stored in register $s4 by 2
	j L9			#go to subroutine L9

L14:
	bge $t6, $t3, done	#branch to done if $t6 >= $t3

	lw $t8, ($t2)		#load word at RAM address contained in $t2 into register $t8
	sw $t8, sparseC($t4)	#store word in sparseC($t4) contained in register $t8
	addi $t4, $t4, 4	#increase value stored in register $t4 by 4
	addi $t2, $t2, 4	#increase value stored in register $t2 by 4

	lw $t8, ($t2)		#load word at RAM address contained in $t2 into register $t8
	sw $t8, sparseC($t4)	#store word in sparseC($t4) contained in register $t8
	addi $t4, $t4, 4	#isncrease value stored in register $t4 by 4
	addi $t2, $t2, 4	#increase value stored in register $t2 by 4

	addi $s4, $s4, 2	#increase value stored in register $s4 by 2
	addi $t6, $t6, 2	#increase value stored in register $t6 by 2
	j L14			#go to subroutine L14

L15:
	bge $t5, $t1, done	#branch to done if $t5 >= $t1

	lw $t7, ($t0)		#load word at RAM address contained in $t0 into register $t7
	sw $t7, sparseC($t4)	#store word in sparseC($t4) contained in register $t7
	addi $t4, $t4, 4	#increase value stored in register $t4 by 4
	addi $t0, $t0, 4	#increase value stored in register $t0 by 4

	lw $t7, ($t0)		#load word at RAM address contained in $t0 into register $t7
	sw $t7, sparseC($t4)	#store word in sparseC($t4) contained in register $t7
	addi $t4, $t4, 4	#increase value stored in register $t4 by 4
	addi $t0, $t0, 4	#increase value stored in register $t0 by 4

	addi $s4, $s4, 2	#increase value stored in register $s4 by 2
	addi $t5, $t5, 2	#increase value stored in register $t5 by 2
	j L15			#go to subroutine L15


printSparseA:
	la $a0, blank	#print a blank line
	li $v0, 4
	syscall

	la $t0, sparseA	#copy RAM address of sparseA into register $t0
	la $t1, 0($s2)	#copy the size of sparseA into register $t1
	li $t2, 0	#load i = 0 into register $t2
	jal L16		#go to subroutine L16

printSparseB:
	la $a0, blank	#print a blank line
	li $v0, 4
	syscall

	la $t0, sparseB	#copy RAM address of sparseB into register $t0
	la $t1, 0($s3)	#copy the size of sparseB into register $t1
	li $t2, 0	#load i = 0 into register $t2
	jal L16		#go to subroutine L16

printSparseC:
	la $a0, blank	#print a blank line
	li $v0, 4
	syscall

	la $t0, sparseC	#copy RAM address of sparseC into register $t0
	la $t1, 0($s4)	#copy the size of sparseC into register $t1
	li $t2, 0	#load i = 0 into register $t2
	jal L16		#go to subroutine L16

L16:
	bge $t2, $t1, done	#branch to done if $t2 >= $t1

	la $a0, pos2	#print message indicating the position in sparseA
	li $v0, 4
	syscall

	lw $t3, ($t0)	#load word at RAM address contained in $t0 into register $t3
	li $v0, 1	#load appropriate system call code into register $v0 in order to print integer
	move $a0, $t3	#move integer to be printed into $a0
	syscall		#call operating system to perform operation

	addi $t0, $t0, 4	#increase value stored in register $t0 by 4
	
	la $a0, value	#print message indicating the value of the specific cell of sparseA
	li $v0, 4
	syscall

	lw $t3, ($t0)	#load word at RAM address contained in $t0 into register $t3
	li $v0, 1	#load appropriate system call code into register $v0 in order to print integer
	move $a0, $t3	#move integer to be printed into $a0
	syscall		#call operating system to perform operation

	addi $t0, $t0, 4	#increase value stored in register $t0 by 4

	la $a0, blank	#print a blank line
	li $v0, 4
	syscall

	addi $t2, $t2, 2	#increase value stored in register $t2 by 2
	j L16			#go to subroutine L16

done:
	la $a0, blank	#print a blank line
	li $v0, 4
	syscall
	
	j main	#go to main


#-----------------------------------------------------------------------------------------------------
# Data declaration section
#-----------------------------------------------------------------------------------------------------
	.data
menu:	.ascii	"Choose one of the following options:\n"
opt1:	.ascii	"1. Read Array A\n"
opt2:	.ascii	"2. Read Array B\n"
opt3:	.ascii	"3. Create Sparse Array A\n"
opt4:	.ascii	"4. Create Sparse Array B\n"
opt5:	.ascii	"5. Create Sparse Array C=A+B\n"
opt6:	.ascii	"6. Display Sparse Array A\n"
opt7:	.ascii	"7. Display Sparse Array B\n"
opt8:	.ascii	"8. Display Sparse Array C\n"
slash:	.ascii	"------------------------------------\n"
opt0:	.ascii	"0. Exit\n"
blank:  .asciiz	"\n"
enterA:	.asciiz	"Enter 10 numbers to be stored in the array A:\n"
enterB:	.asciiz	"Enter 10 numbers to be stored in the array B:\n"
pos:	.asciiz	"Position "
pos2:	.asciiz	"Position: "
value:	.asciiz "  Value: "
mark:	.asciiz	": "

	.align 2	#align next data item on word boundary
arrayA:	.space 40	#allocate 40 consecutive bytes in order to create a 10-element integer array
	.align 2	#align next data item on word boundary
arrayB: .space 40	#allocate 40 consecutive bytes in order to create a 10-element integer array
	.align 2	#align next data item on word boundary
sparseA: .space 80	#allocate 80 consecutive bytes in order to create a 10-element integer array
	.align 2	#align next data item on word boundary
sparseB: .space 80	#allocate 80 consecutive bytes in order to create a 10-element integer array
	.align 2	#align next data item on word boundary
sparseC: .space 80	#allocate 80 consecutive bytes in order to create a 10-element integer array
