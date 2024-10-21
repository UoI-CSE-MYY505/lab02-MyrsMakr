
.data

array: .word 1, 0, 1, 12, 0, 1, 4

.text

    la a0, array
    li a1, 7    # unsigned
    li a2, 1
prog:
#-----------------------------


#I'm using a loop in order to run through the array
use_reg_as_pointer:
    add s0, zero, zero
loop1:
    beq a1, zero, first
    lw t1, 0(a0)
    bne t1, a2, second
    add s0, a0, zero
second:
    addi a0, a0, 4
    addi a1/a1, -1
    j    loop1
first:
    addi a7, zero, 10
    ecall


#-----------------------------
done:
    addi a7, zero, 10 
    ecall
        
        # Instructions are indented a few spaces to the right
        #   (so that we can see the labels more clearly)
        # Instruction operands are indented a few spaces, so that the
        #    instruction type is more visible.
      
        la         a0, matric      # a0 gets the **address** of matric
                                   # Note: this is address **not** value of matric
        la         a1, var1        # a1 gets address of var1
        la         a2, array       # get address of array into a2
                                   # This is called the **base** of the array
        la         a3, var2        # Get address of var2

prog:   # Labels in code are used for control flow: if/then/else, loops, etc.
        #  In this case the label is required for the course's automated
        #  test.
        # Labels do not take up space in memory. They are only used by the assembler

        lw         s0, 0(a0)       
        
        lw         s1, 0(a1)       # s1 gets the value of var1. a1 has the address of var1
        add        s1, s1,   s0    # s1 = var1 + s0
        sw         s1, 4(a0)       # matricplus1 = var1 + s0
        
        sw         s0, 0xc(a2)     # Store s0 to the 4th element of array
                                   # Note the use of offset (0xc = 12 = 3*4)
                                   # addresses of array elements (32bit words each):
                                   # array[0]  - array + 0
                                   # array[1]  - array + 4
                                   # array[2]  - array + 8
                                   # array[3]  - array + 12
                                     
        addi       t1, a2,   0x10  # Note: address arithmetic.
                                   #  Calculates address of 5th element of array
        sw         t1, 0(a1)       # var1 = address of 5th element of array 
                                   # Note: we can store addresses 
                                   #   in memory just like we do with real data!
        
        lb         s2, 0(a3)       # Get value of var2, sign-extended to 32 bits, to s2
        lbu        s3, 0(a3)       # Get value of var2, zero-extended to 32 bits, to s3
        
exit: 
        addi       a7, zero, 10   # system service 10 is exit
        ecall                     # we are outa here.
        
###############################################################################
