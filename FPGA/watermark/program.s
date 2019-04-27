
        .text
main:

        # setup
        li $t0, 0       # always zero
        li $t1, 1       # always one
        li $t2, 4095    # maximum value
        li $t3, 0       # pixel counter
        li $t4, 0xFFF       # image pixel
        li $t5, 0xFFF       # water pixel
        li $t6, 0       # regout pixel

        # temp hold the individual vals
        li $s0, 0x0       # image R, G, B temp
        li $s1, 0x0       # water R, G, B temp
        li $s2, 0       # regout R, G, B temp

        # masks for extracting values
        li $s3, 0x000000F0      # mask for G
        li $s4, 0x0000000F      # mask for B

        li $s5, 0       # temp hold a result


        # program
        # operations: add, sub, and, or, srl, sll
        # pixels: R, G, B
Loop:
        # reset the pixel's value to black
        sub $t6, $t6, $t6       # clear output to 0

        # get R pixel
        srl $s0, $t4, 8         # image R
        srl $s1, $t5, 8         # water R
        # average the red to temp
        add $s5, $s0, $s1       # add
        srl $s5, $s5, 1         # divide by 2
        sll $s5, $s5, 8         # shift back to R position
        # store averaged red pixel
        or $t6, $t6, $s5        # put the value at R
        

        # get G pixel
        and $s0, $t4, $s3       # temp_image = image_pixel & g_mask
        srl $s0, $s0, 4         # image G
        and $s1, $t5, $s3       # temp_water = water_pixel & g_mask
        srl $s1, $s1, 4         # water G
        # average the green to temp
        add $s5, $s0, $s1       # add
        srl $s5, $s5, 1         # divide by 2
        sll $s5, $s5, 4         # shift back to G position
        # store averaged green pixel
        or $t6, $t6, $s5        # put the value at G


        # get B pixel
        and $s0, $t4, $s4       # temp_image = image_pixel & b_mask == image B
        and $s1, $t5, $s4       # temp_water = water_pixel & b_mask == water B
        # average the green to temp
        add $s5, $s0, $s1       # add
        srl $s5, $s5, 1         # divide by 2
        # store averaged blue pixel
        or $t6, $t6, $s5


        # increment then check if counter has reached its max value
        #add $t3, $t3, $t1               # counter = counter + 1
        #beq $t3, $t2, ResetCounter      # jump to ResetCounter if counter == 4095

        #bne $t0, $t1, Loop      # loop again if not resetting the counter

#ResetCounter:
        #sub $t3, $t3, $t3       # reset counter to zero
        #bne $t0, $t1, Loop      # jump back to loop


        # return to caller
        jr $ra
