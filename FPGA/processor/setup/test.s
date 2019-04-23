
# run in QTSpim

        .text
main:
        # setup
        li $t1, 0x7fffeb60
        li $t2, 8
        sw $t2, 0($t1)
        lw $t3, 0($t1)

        # program
        add $t4, $t2, $t3
        srl $t4, $t4, 1

        # return to caller
        jr $ra
