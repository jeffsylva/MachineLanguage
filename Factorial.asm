#JEFFERSON SYLVA-IRIOGBE
#001163953
#ASSIGNMENT 3
#PROGRAM TO CALCULATE THE FACTORIAL OF A GIVEN SET OF NUMBERS

.text
main:

la $a0, prompt_input #Load address of prompt_input to a0
li $v0, 4 #Print string function in syscall
syscall

li $v0, 5 #Read integer function in syscall
syscall

move $t0, $v0 #Copy input integer from v0 to t0


factorial_stack_prep:
addi $sp, $sp, -12 
sw $t0, 0($sp) #storing input number
sw $ra, 8($sp) #save program counter

jal factorial

lw $ra, 8($sp) #restore program counter
lw $s0, 4($sp) #load result of factorial
addi $sp, $sp, 12 #deallocate 


#printing factorial result

la $a0, prompt_factorial_result #Load address of prompt_factorial_result to a0
li $v0, 4 #Print string function in syscall
syscall

move $a0, $s0 #Load address of current element in t2 to a0
li $v0, 1 #Print integer function in syscall
syscall

#Exit
li $v0, 10 #Exit function in syscall
syscall


factorial:
lw $t0, 0($sp) #load input from stack
beq $t0, 0, return #goto return if t0 == 0
addi $t0, $t0, -1 #input n - 1

#recursive call to calculate input n factorial
addi $sp, $sp, -12 #allocate 12 bytes
sw $t0, 0($sp) #storing input to sp offset 0
sw $ra, 8($sp) #storing return address to sp offset 8
jal factorial 

#loading return value
lw $t1, 4($sp) #load result to t1
lw $ra, 8($sp) #load program counter address to ra

addiu $sp, $sp, 12 

lw $t0, 0($sp) #load input n
mul $t2, $t1, $t0 #multiply n by n-1
sw $t2, 4($sp) #store result in stack

jr $ra #jump to return address register ra


return:
li $t0, 1 
sw $t0, 4($sp) #storing input to sp offset 0
jr $ra #jump to return address register ra


.data
prompt_input: .asciiz "Enter some numbers: \n"
prompt_factorial_result: .asciiz "The factorial of the numbers you inputted is: \n"

