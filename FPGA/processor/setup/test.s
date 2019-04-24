
# run in QTSpim

        .text
main:
        # setup
        li $t1, 16
        li $t2, 0x7fffeb60
        li $t3, 8
        li $t4, 0

        # program
loop:
        add $t4, $t4, $t3
        beq $t4, $t3, loop
        add $t4, $t4, $t3
        beq $t4, $t1, loop
        add $t4, $t4, $t3


        # return to caller
        jr $ra
