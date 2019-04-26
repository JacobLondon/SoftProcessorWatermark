

        .text
main:

        # setup
        li $t0, 0       # always zero
        li $t1, 1
        li $t2, 4095
        li $t3, 1
        li $t4, 64      # counter
        li $t5, 0       # flag
        li $t6, 0       # regout

loop1:
        add $t6, $t4, $t1
        add $t3, $t3, $t1

        # todo


        # return to caller
        jr $ra


