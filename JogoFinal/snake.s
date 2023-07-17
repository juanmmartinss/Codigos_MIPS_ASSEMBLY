# MARCO ANTONIO CORAL DOS SANTOS RA 158467
# JUAN MARCOS MARTINS RA 156470
# RAPHAEL DAMASCENO RA 156380

# PROJETO FINAL DE ARQUITETURA E ORGANIZACAO DE COMPUTADORES
# PROFESSOR: FABIO CAPPABIANCO
# UNIVERSIDADE FEDERAL DE SAO PAULO - CAMPUS DE SAO JOSE DOS CAMPOS

# JOGO DA COBRA - ASSEMBLY MIPS

.data

pixels:     .space 16384

score_background_color:         .word 0x4a752c
score_color:                    .word 0xffffff
borders_color:                  .word 0x578a34
board_background_color:         .word 0xaad751
apple_score_color1:             .word 0xe7471d
apple_score_color2:             .word 0xee755c
apple_score_leaf_color:         .word 0x49c227
apple_score_stem_color:         .word 0x976e4c
snake_color:                    .word 0x4673e9
apple_color:                    .word 0xe7471d
trophy_color1:                  .word 0xfdc001
trophy_color2:                  .word 0xffda88

direction_up:                 .word 0x01000000
direction_left:               .word 0x02000000
direction_down:               .word 0x04000000
direction_right:              .word 0x08000000

str_game_over:      .asciiz "\nFim de jogo! Sua pontuacao foi: "
str_play_again:     .asciiz "\nDeseja jogar novamente?"

.text

main:

    li $t9, 1  # registrador auxiliar para o highscore (inicializado com 1)

draw_board_background_color:

    li $s0, 0  # pontuacao inicial zerada

    la $t0, pixels # carrega o endereco inicial da tela na registrador $t0
    li $t1, 4096  # numero de pixels a serem desenhados
    lw $t2, board_background_color  # carrega a cor do fundo na registrador $t2

draw_board_background_color_loop:

    sw $t2, 0($t0)  # pinta o pixel
    addi $t0, $t0, 4  # avanca para o proximo pixel
    addi $t1, $t1, -1  # decrementa o contador de pixels
    bnez $t1, draw_board_background_color_loop  # se ainda houver pixels a serem pintados, volta para o loop

draw_score_background:

    la $t0, pixels  
    li $t1, 640   # numero de pixels a serem desenhados
    lw $t2, score_background_color 

draw_score_background_loop:

    sw $t2, 0($t0)  
    addi $t0, $t0, 4  
    addi $t1, $t1, -1  
    bnez $t1, draw_score_background_loop  

draw_borders:

    lw $t2, borders_color  # carrega a cor das bordas na registrador $t2

draw_top_border:

    la $t0, pixels  
    add $t0, $t0, 2560  # avanca para a posicao inicial das bordas
    li $t1, 192  # numero de pixels a serem desenhados

draw_top_border_loop:

    sw $t2, 0($t0)  
    addi $t0, $t0, 4  
    addi $t1, $t1, -1  
    bnez $t1, draw_top_border_loop  

draw_bottom_border:

    la $t0, pixels  
    add $t0, $t0, 15616  # avanca para a posicao inicial das bordas
    li $t1, 192  # numero de pixels a serem desenhados

draw_bottom_border_loop:

    sw $t2, 0($t0)  
    addi $t0, $t0, 4  
    addi $t1, $t1, -1  
    bnez $t1, draw_bottom_border_loop  

draw_left_border:

    la $t0, pixels  
    add $t0, $t0, 3328  # avanca para a posicao inicial das bordas
    li $t1, 144  # numero de pixels a serem desenhados

draw_left_border_loop:

    sw $t2, 0($t0)  
    addi $t0, $t0, 4  
    sw $t2, 0($t0)  
    addi $t0, $t0, 4  
    sw $t2, 0($t0)  # pinta 3 pixels de uma vez para ter uma borda mais grossa
    addi $t0, $t0, 248  # pula para a proxima linha
    addi $t1, $t1, -3   # decrementa o contador de pixels em 3
    bnez $t1, draw_left_border_loop  

draw_right_border:

    la $t0, pixels  
    add $t0, $t0, 3572  # avanca para a posicao inicial das bordas
    li $t1, 144  # numero de pixels a serem desenhados

draw_right_border_loop:

    sw $t2, 0($t0)  
    addi $t0, $t0, 4  
    sw $t2, 0($t0)  
    addi $t0, $t0, 4  
    sw $t2, 0($t0)  
    addi $t0, $t0, 248  
    addi $t1, $t1, -3  
    bnez $t1, draw_right_border_loop  

draw_apple_on_score:

    la $t0, pixels  
    
    lw $t2, apple_score_stem_color  # carrega a cor do caule na registrador $t2
    sw $t2, 284($t0)  

    lw $t2, apple_score_leaf_color  # carrega a cor da folha na registrador $t2
    sw $t2, 288($t0)  
    sw $t2, 292($t0)

    lw $t2, apple_score_stem_color  
    sw $t2, 536($t0)  

    lw $t2, apple_score_color1 # carrega a cor da ma?? na registrador $t2
    sw $t2, 784($t0)  
    sw $t2, 788($t0)  
    sw $t2, 792($t0)  
    sw $t2, 796($t0)  

    sw $t2, 1036($t0)  
    sw $t2, 1040($t0)  

    lw $t2, apple_score_color2 # carrega a cor da ma?? na registrador $t2
    sw $t2, 1044($t0)  

    lw $t2, apple_score_color1
    sw $t2, 1048($t0)  
    sw $t2, 1052($t0)  
    sw $t2, 1056($t0)

    sw $t2, 1292($t0)

    lw $t2, apple_score_color2
    sw $t2, 1296($t0)
    sw $t2, 1300($t0)

    lw $t2, apple_score_color1
    sw $t2, 1304($t0)
    sw $t2, 1308($t0)
    sw $t2, 1312($t0)

    sw $t2, 1548($t0)
    sw $t2, 1552($t0)
    sw $t2, 1556($t0)
    sw $t2, 1560($t0)
    sw $t2, 1564($t0)
    sw $t2, 1568($t0)

    sw $t2, 1804($t0)
    sw $t2, 1808($t0)
    sw $t2, 1812($t0)
    sw $t2, 1816($t0)
    sw $t2, 1820($t0)
    sw $t2, 1824($t0)

    sw $t2, 2064($t0)
    sw $t2, 2068($t0)
    sw $t2, 2072($t0)
    sw $t2, 2076($t0)

draw_initial_score:

    lw $t2, score_color
    la $t0, pixels
    sw $t2, 564($t0)
    sw $t2, 568($t0)
    sw $t2, 572($t0)
    sw $t2, 576($t0)
    sw $t2, 580($t0)
    sw $t2, 820($t0) 
    sw $t2, 836($t0)
    sw $t2, 1076($t0)
    sw $t2, 1092($t0)
    sw $t2, 1332($t0)
    sw $t2, 1348($t0)
    sw $t2, 1588($t0)
    sw $t2, 1604($t0)
    sw $t2, 1844($t0)
    sw $t2, 1860($t0)
    sw $t2, 2100($t0)
    sw $t2, 2104($t0)
    sw $t2, 2108($t0)
    sw $t2, 2112($t0)
    sw $t2, 2116($t0)

    la $t0, pixels
    sw $t2, 588($t0)
    sw $t2, 592($t0)
    sw $t2, 596($t0)
    sw $t2, 600($t0)
    sw $t2, 604($t0)
    sw $t2, 844($t0)
    sw $t2, 860($t0)
    sw $t2, 1100($t0)
    sw $t2, 1116($t0)
    sw $t2, 1356($t0)
    sw $t2, 1372($t0)
    sw $t2, 1612($t0)
    sw $t2, 1628($t0)
    sw $t2, 1868($t0)
    sw $t2, 1884($t0)
    sw $t2, 2124($t0)
    sw $t2, 2128($t0)
    sw $t2, 2132($t0)
    sw $t2, 2136($t0)
    sw $t2, 2140($t0)

draw_trophy:

    lw $t2, trophy_color1
    la $t0, pixels

    sw $t2, 364($t0)
    sw $t2, 368($t0)
    sw $t2, 372($t0)
    sw $t2, 376($t0)
    sw $t2, 380($t0)
    sw $t2, 384($t0)
    sw $t2, 388($t0)
    sw $t2, 392($t0)
    sw $t2, 396($t0)

    sw $t2, 620($t0)
    sw $t2, 628($t0)
    lw $t2, trophy_color2
    sw $t2, 632($t0)
    lw $t2, trophy_color1
    sw $t2, 636($t0)
    sw $t2, 640($t0)
    sw $t2, 644($t0)
    sw $t2, 652($t0)

    sw $t2, 876($t0)
    sw $t2, 884($t0)
    lw $t2, trophy_color2
    sw $t2, 888($t0)
    lw $t2, trophy_color1
    sw $t2, 892($t0)
    sw $t2, 896($t0)
    sw $t2, 900($t0)
    sw $t2, 908($t0)

    sw $t2, 1136($t0)
    sw $t2, 1140($t0)
    sw $t2, 1144($t0)
    sw $t2, 1148($t0)
    sw $t2, 1152($t0)
    sw $t2, 1156($t0)
    sw $t2, 1160($t0)

    sw $t2, 1396($t0)
    sw $t2, 1400($t0)
    sw $t2, 1404($t0)
    sw $t2, 1408($t0)
    sw $t2, 1412($t0)

    sw $t2, 1656($t0)
    sw $t2, 1660($t0)
    sw $t2, 1664($t0)

    sw $t2, 1916($t0)

    sw $t2, 2164($t0)
    sw $t2, 2168($t0)
    sw $t2, 2172($t0)
    sw $t2, 2176($t0)
    sw $t2, 2180($t0)

    beq $t9, $zero, draw_current_highscore

draw_initial_highscore:

    lw $t2, score_color
    la $t0, pixels
    sw $t2, 668($t0)
    sw $t2, 672($t0)
    sw $t2, 676($t0)
    sw $t2, 680($t0)
    sw $t2, 684($t0)
    sw $t2, 924($t0)
    sw $t2, 940($t0)
    sw $t2, 1180($t0)
    sw $t2, 1196($t0)
    sw $t2, 1436($t0)
    sw $t2, 1452($t0)
    sw $t2, 1692($t0)
    sw $t2, 1708($t0)
    sw $t2, 1948($t0)
    sw $t2, 1964($t0)
    sw $t2, 2204($t0)
    sw $t2, 2208($t0)
    sw $t2, 2212($t0)
    sw $t2, 2216($t0)
    sw $t2, 2220($t0)

    lw $t2, score_color
    la $t0, pixels
    sw $t2, 692($t0)
    sw $t2, 696($t0)
    sw $t2, 700($t0)
    sw $t2, 704($t0)
    sw $t2, 708($t0)
    sw $t2, 948($t0)
    sw $t2, 964($t0)
    sw $t2, 1204($t0)
    sw $t2, 1220($t0)
    sw $t2, 1460($t0)
    sw $t2, 1476($t0)
    sw $t2, 1716($t0)
    sw $t2, 1732($t0)
    sw $t2, 1972($t0)
    sw $t2, 1988($t0)
    sw $t2, 2228($t0)
    sw $t2, 2232($t0)
    sw $t2, 2236($t0)
    sw $t2, 2240($t0)
    sw $t2, 2244($t0)

    addi $t9, $t9, -1

    j draw_initial_snake

draw_current_highscore:

    jal draw_highscore

draw_initial_snake:

    la $t0, pixels
    addi $t0, $t0, 9504 # avanca para a posicao inicial da cobra
    add $s1, $t0, $zero # salva a posicao inicial da cobra em $s1
    lw $t1, snake_color # carrega a cor da cobra
    sw $t1, 0($t0) # desenha o primeiro pixel da cobra

    lw $t2, direction_right # carrega o valor da direita na registrador $t2
    add $t1, $t1, $t2 # soma o valor da direita com a cor da cobra
    sw $t1, -4($t0) # desenha o segundo pixel da cobra

    add $t0, $t0, -4
    add $s2, $t0, $zero # salva a posicao da cauda da cobra em $s2

    jal generate_random_position_for_the_apple
    jal generate_random_position_for_the_apple
    jal generate_random_position_for_the_apple
    jal generate_random_position_for_the_apple
    jal generate_random_position_for_the_apple

    li $s5, 50 # velocidade maxima da cobra
    li $s4, 120 # velocidade inicial da cobra
    j   main_loop   # inicia o loop principal

update_head_position:

    lw  $t0, 0($s1)             
    add $t0, $t0, $s3            
    sw  $t0, 0($s1)            

    lw  $t0, direction_up
    beq $s3, $t0, update_head_position_up

    lw  $t0, direction_left
    beq $s3, $t0, update_head_position_left

    lw  $t0, direction_down
    beq $s3, $t0, update_head_position_down

    lw  $t0, direction_right
    beq $s3, $t0, update_head_position_right

update_head_position_up:

    add $s1, $s1, -256          
    j   check_if_there_was_collision

update_head_position_left:
    add $s1, $s1, -4            
    j   check_if_there_was_collision

update_head_position_down:
    add $s1, $s1, 256           
    j   check_if_there_was_collision

update_head_position_right:
    add $s1, $s1, 4             
    j   check_if_there_was_collision

check_if_there_was_collision:

    lw  $t0, 0($s1)             
    lw  $t1, apple_color          
    beq $t0, $t1, snake_ate_the_apple   

    lw  $t1, board_background_color            
    beq $t0, $t1, continue          

    j   game_over

continue:

    lw  $t0, 0($s2)             
    li  $t1, 0xff000000
    and $t0, $t0, $t1           
                                
    lw  $t1, board_background_color           
    sw  $t1, 0($s2)             

    lw  $t1, direction_up                 
    beq $t0, $t1, update_tail_position_up    

    lw  $t1, direction_left
    beq $t0, $t1, update_tail_position_left

    lw  $t1, direction_down
    beq $t0, $t1, update_tail_position_down

    lw  $t1, direction_right
    beq $t0, $t1, update_tail_position_right

update_tail_position_up:

    add $s2, $s2, -256
    j   draw_updated_head

update_tail_position_down:

    add $s2, $s2, 256
    j   draw_updated_head

update_tail_position_left:

    add $s2, $s2, -4
    j   draw_updated_head

update_tail_position_right:

    add $s2, $s2, 4
    j   draw_updated_head

draw_updated_head:
    lw  $t0, snake_color     
    sw  $t0, 0($s1)
    j   main_loop

snake_ate_the_apple:

    addi $s0, $s0, 1  # aumenta a pontuacao em 1

    beq $s4, $s5, generate_new_apple # verifica se a velocidade ja eh a maxima
    addi $s4, $s4, -3 # aumenta a velocidade em 3  

generate_new_apple:

    jal generate_random_position_for_the_apple      
    
    jal update_score

    jal update_highscore

    j   draw_updated_head               

generate_random_position_for_the_apple:

    li  $v0, 42
    li  $a1, 15616      # ultimo pixel do tabuleiro ( limite superior )
    syscall 

    la  $t0, pixels    
    sll $a0, $a0, 2     
    add $t0, $t0, $a0   

    lw  $t1, 0($t0)                     
    lw  $t2, board_background_color         # verifica se o pixel aleatorio eh um pixel do tabuleiro           
    bne $t1, $t2, generate_random_position_for_the_apple    # senao for, gera outro numero aleatorio

draw_food:

    lw  $t1, apple_color      # apos verificar se a posicao eh valida
    sw  $t1, 0($t0)           # desenha a ma??
    jr  $ra

main_loop:

    lw  $t0, 0xffff0004   # le o input do teclado

    li $v0, 32     # syscall para dar sleep no programa         
    li $a0, 50     # quantidade em milisegundos para dar sleep
    syscall

    beq $t0, 119, input_equals_w      
    beq $t0, 115, input_equals_s    
    beq $t0, 97, input_equals_a    
    beq $t0, 100, input_equals_d   

    j   main_loop

input_equals_w:

    lw $t1, direction_down               
    beq $s3, $t1, update_head_position    

    lw $s3, direction_up                 
    j update_head_position             
     
input_equals_s:
    lw $t1, direction_up                 
    beq $s3, $t1, update_head_position   

    lw $s3, direction_down               
    j update_head_position             
input_equals_a:

    lw $t1, direction_right           
    beq $s3, $t1, update_head_position    

    beqz $s3, main_loop           
                                   
    lw $s3, direction_left              
    j update_head_position 

input_equals_d:

    lw $t1, direction_left               
    beq $s3, $t1, update_head_position   

    lw $s3, direction_right              
    j update_head_position              
    
update_score:

    la $t0, pixels  
    addi $t0, $t0, 640
    li $t1, 15   # numero de pixels a serem desenhados

score_board:
    
    move $t0, $s0
    li $t1, 10
    div $t0, $t1
    mfhi $t3
    mflo $t4

unit_digit_of_score:

    beq $t3, 0, draw_zero_unit_score
    beq $t3, 1, draw_one_unit_score
    beq $t3, 2, draw_two_unit_score
    beq $t3, 3, draw_three_unit_score
    beq $t3, 4, draw_four_unit_score
    beq $t3, 5, draw_five_unit_score
    beq $t3, 6, draw_six_unit_score
    beq $t3, 7, draw_seven_unit_score
    beq $t3, 8, draw_eight_unit_score
    beq $t3, 9, draw_nine_unit_score

draw_zero_unit_score:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 588($t0)
    sw $t2, 592($t0)
    sw $t2, 596($t0)
    sw $t2, 600($t0)
    sw $t2, 604($t0)
    sw $t2, 844($t0)
    sw $t2, 860($t0)
    sw $t2, 1100($t0)
    sw $t2, 1116($t0)
    sw $t2, 1356($t0)
    sw $t2, 1360($t0)
    sw $t2, 1364($t0)
    sw $t2, 1368($t0)
    sw $t2, 1372($t0)
    sw $t2, 1628($t0)
    sw $t2, 1884($t0)
    sw $t2, 2124($t0)
    sw $t2, 2128($t0)
    sw $t2, 2132($t0)
    sw $t2, 2136($t0)
    sw $t2, 2140($t0)

    lw $t2, score_color
    la $t0, pixels  
    sw $t2, 588($t0)
    sw $t2, 592($t0)
    sw $t2, 596($t0)
    sw $t2, 600($t0)
    sw $t2, 604($t0)
    sw $t2, 844($t0)
    sw $t2, 860($t0)
    sw $t2, 1100($t0)
    sw $t2, 1116($t0)
    sw $t2, 1356($t0)
    sw $t2, 1372($t0)
    sw $t2, 1612($t0)
    sw $t2, 1628($t0)
    sw $t2, 1868($t0)
    sw $t2, 1884($t0)
    sw $t2, 2124($t0)
    sw $t2, 2128($t0)
    sw $t2, 2132($t0)
    sw $t2, 2136($t0)
    sw $t2, 2140($t0)

    j dozen_digit_of_score

draw_one_unit_score:

    lw $t2, score_background_color
    la $t0, pixels  
    sw $t2, 588($t0)
    sw $t2, 592($t0)
    sw $t2, 596($t0)
    sw $t2, 600($t0)
    sw $t2, 604($t0)
    sw $t2, 844($t0)
    sw $t2, 860($t0)
    sw $t2, 1100($t0)
    sw $t2, 1116($t0)
    sw $t2, 1356($t0)
    sw $t2, 1372($t0)
    sw $t2, 1612($t0)
    sw $t2, 1628($t0)
    sw $t2, 1868($t0)
    sw $t2, 1884($t0)
    sw $t2, 2124($t0)
    sw $t2, 2128($t0)
    sw $t2, 2132($t0)
    sw $t2, 2136($t0)
    sw $t2, 2140($t0)
    
    lw $t2, score_color
    la $t0, pixels
    sw $t2, 604($t0)
    sw $t2, 860($t0)
    sw $t2, 1116($t0)
    sw $t2, 1372($t0)
    sw $t2, 1628($t0)
    sw $t2, 1884($t0)
    sw $t2, 2140($t0)

    j dozen_digit_of_score

draw_two_unit_score:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 604($t0)
    sw $t2, 860($t0)
    sw $t2, 1116($t0)
    sw $t2, 1372($t0)
    sw $t2, 1628($t0)
    sw $t2, 1884($t0)
    sw $t2, 2140($t0)
    
    lw $t2, score_color
    la $t0, pixels
    sw $t2, 588($t0)
    sw $t2, 592($t0)
    sw $t2, 596($t0)
    sw $t2, 600($t0)
    sw $t2, 604($t0)
    sw $t2, 860($t0)
    sw $t2, 1116($t0)
    sw $t2, 1356($t0)
    sw $t2, 1360($t0)
    sw $t2, 1364($t0)
    sw $t2, 1368($t0)
    sw $t2, 1372($t0)
    sw $t2, 1612($t0)
    sw $t2, 1868($t0)
    sw $t2, 2124($t0)
    sw $t2, 2128($t0)
    sw $t2, 2132($t0)
    sw $t2, 2136($t0)
    sw $t2, 2140($t0)

    j dozen_digit_of_score

draw_three_unit_score:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 588($t0)
    sw $t2, 592($t0)
    sw $t2, 596($t0)
    sw $t2, 600($t0)
    sw $t2, 604($t0)
    sw $t2, 860($t0)
    sw $t2, 1116($t0)
    sw $t2, 1356($t0)
    sw $t2, 1360($t0)
    sw $t2, 1364($t0)
    sw $t2, 1368($t0)
    sw $t2, 1372($t0)
    sw $t2, 1612($t0)
    sw $t2, 1868($t0)
    sw $t2, 2124($t0)
    sw $t2, 2128($t0)
    sw $t2, 2132($t0)
    sw $t2, 2136($t0)
    sw $t2, 2140($t0)
    
    lw $t2, score_color
    la $t0, pixels
    sw $t2, 588($t0)
    sw $t2, 592($t0)
    sw $t2, 596($t0)
    sw $t2, 600($t0)
    sw $t2, 604($t0)
    sw $t2, 860($t0)
    sw $t2, 1116($t0)
    sw $t2, 1356($t0)
    sw $t2, 1360($t0)
    sw $t2, 1364($t0)
    sw $t2, 1368($t0)
    sw $t2, 1372($t0)
    sw $t2, 1628($t0)
    sw $t2, 1884($t0)
    sw $t2, 2124($t0)
    sw $t2, 2128($t0)
    sw $t2, 2132($t0)
    sw $t2, 2136($t0)
    sw $t2, 2140($t0)

    j dozen_digit_of_score

draw_four_unit_score:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 588($t0)
    sw $t2, 592($t0)
    sw $t2, 596($t0)
    sw $t2, 600($t0)
    sw $t2, 604($t0)
    sw $t2, 860($t0)
    sw $t2, 1116($t0)
    sw $t2, 1356($t0)
    sw $t2, 1360($t0)
    sw $t2, 1364($t0)
    sw $t2, 1368($t0)
    sw $t2, 1372($t0)
    sw $t2, 1628($t0)
    sw $t2, 1884($t0)
    sw $t2, 2124($t0)
    sw $t2, 2128($t0)
    sw $t2, 2132($t0)
    sw $t2, 2136($t0)
    sw $t2, 2140($t0)
    
    lw $t2, score_color
    la $t0, pixels
    sw $t2, 588($t0)
    sw $t2, 604($t0)
    sw $t2, 844($t0)
    sw $t2, 860($t0)
    sw $t2, 1100($t0)
    sw $t2, 1116($t0)
    sw $t2, 1356($t0)
    sw $t2, 1360($t0)
    sw $t2, 1364($t0)
    sw $t2, 1368($t0)
    sw $t2, 1372($t0)
    sw $t2, 1628($t0)
    sw $t2, 1884($t0)
    sw $t2, 2140($t0)

    j dozen_digit_of_score

draw_five_unit_score:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 588($t0)
    sw $t2, 604($t0)
    sw $t2, 844($t0)
    sw $t2, 860($t0)
    sw $t2, 1100($t0)
    sw $t2, 1116($t0)
    sw $t2, 1356($t0)
    sw $t2, 1360($t0)
    sw $t2, 1364($t0)
    sw $t2, 1368($t0)
    sw $t2, 1372($t0)
    sw $t2, 1628($t0)
    sw $t2, 1884($t0)
    sw $t2, 2140($t0)

    lw $t2, score_color
    la $t0, pixels
    sw $t2, 588($t0)
    sw $t2, 592($t0)
    sw $t2, 596($t0)
    sw $t2, 600($t0)
    sw $t2, 604($t0)
    sw $t2, 844($t0)
    sw $t2, 1100($t0)
    sw $t2, 1356($t0)
    sw $t2, 1360($t0)
    sw $t2, 1364($t0)
    sw $t2, 1368($t0)
    sw $t2, 1372($t0)
    sw $t2, 1628($t0)
    sw $t2, 1884($t0)
    sw $t2, 2124($t0)
    sw $t2, 2128($t0)
    sw $t2, 2132($t0)
    sw $t2, 2136($t0)
    sw $t2, 2140($t0)

    j dozen_digit_of_score

draw_six_unit_score:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 588($t0)
    sw $t2, 592($t0)
    sw $t2, 596($t0)
    sw $t2, 600($t0)
    sw $t2, 604($t0)
    sw $t2, 844($t0)
    sw $t2, 1100($t0)
    sw $t2, 1356($t0)
    sw $t2, 1360($t0)
    sw $t2, 1364($t0)
    sw $t2, 1368($t0)
    sw $t2, 1372($t0)
    sw $t2, 1628($t0)
    sw $t2, 1884($t0)
    sw $t2, 2124($t0)
    sw $t2, 2128($t0)
    sw $t2, 2132($t0)
    sw $t2, 2136($t0)
    sw $t2, 2140($t0)

    lw $t2, score_color
    la $t0, pixels
    sw $t2, 588($t0)
    sw $t2, 592($t0)
    sw $t2, 596($t0)
    sw $t2, 600($t0)
    sw $t2, 604($t0)
    sw $t2, 844($t0)
    sw $t2, 1100($t0)
    sw $t2, 1356($t0)
    sw $t2, 1360($t0)
    sw $t2, 1364($t0)
    sw $t2, 1368($t0)
    sw $t2, 1372($t0)
    sw $t2, 1612($t0)
    sw $t2, 1628($t0)
    sw $t2, 1868($t0)
    sw $t2, 1884($t0)
    sw $t2, 2124($t0)
    sw $t2, 2128($t0)
    sw $t2, 2132($t0)
    sw $t2, 2136($t0)
    sw $t2, 2140($t0)

    j dozen_digit_of_score

draw_seven_unit_score:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 588($t0)
    sw $t2, 592($t0)
    sw $t2, 596($t0)
    sw $t2, 600($t0)
    sw $t2, 604($t0)
    sw $t2, 844($t0)
    sw $t2, 1100($t0)
    sw $t2, 1356($t0)
    sw $t2, 1360($t0)
    sw $t2, 1364($t0)
    sw $t2, 1368($t0)
    sw $t2, 1372($t0)
    sw $t2, 1612($t0)
    sw $t2, 1628($t0)
    sw $t2, 1868($t0)
    sw $t2, 1884($t0)
    sw $t2, 2124($t0)
    sw $t2, 2128($t0)
    sw $t2, 2132($t0)
    sw $t2, 2136($t0)
    sw $t2, 2140($t0)

    lw $t2, score_color
    la $t0, pixels
    sw $t2, 588($t0)
    sw $t2, 592($t0)
    sw $t2, 596($t0)
    sw $t2, 600($t0)
    sw $t2, 604($t0)
    sw $t2, 860($t0)
    sw $t2, 1116($t0)
    sw $t2, 1372($t0)
    sw $t2, 1628($t0)
    sw $t2, 1884($t0)
    sw $t2, 2140($t0)

    j dozen_digit_of_score

draw_eight_unit_score:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 588($t0)
    sw $t2, 592($t0)
    sw $t2, 596($t0)
    sw $t2, 600($t0)
    sw $t2, 604($t0)
    sw $t2, 860($t0)
    sw $t2, 1116($t0)
    sw $t2, 1372($t0)
    sw $t2, 1628($t0)
    sw $t2, 1884($t0)
    sw $t2, 2140($t0)

    lw $t2, score_color
    la $t0, pixels
    sw $t2, 588($t0)
    sw $t2, 592($t0)
    sw $t2, 596($t0)
    sw $t2, 600($t0)
    sw $t2, 604($t0)
    sw $t2, 844($t0)
    sw $t2, 860($t0)
    sw $t2, 1100($t0)
    sw $t2, 1116($t0)
    sw $t2, 1356($t0)
    sw $t2, 1360($t0)
    sw $t2, 1364($t0)
    sw $t2, 1368($t0)
    sw $t2, 1372($t0)
    sw $t2, 1612($t0)
    sw $t2, 1628($t0)
    sw $t2, 1868($t0)
    sw $t2, 1884($t0)
    sw $t2, 2124($t0)
    sw $t2, 2128($t0)
    sw $t2, 2132($t0)
    sw $t2, 2136($t0)
    sw $t2, 2140($t0)

    j dozen_digit_of_score

draw_nine_unit_score:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 588($t0)
    sw $t2, 592($t0)
    sw $t2, 596($t0)
    sw $t2, 600($t0)
    sw $t2, 604($t0)
    sw $t2, 844($t0)
    sw $t2, 860($t0)
    sw $t2, 1100($t0)
    sw $t2, 1116($t0)
    sw $t2, 1356($t0)
    sw $t2, 1360($t0)
    sw $t2, 1364($t0)
    sw $t2, 1368($t0)
    sw $t2, 1372($t0)
    sw $t2, 1612($t0)
    sw $t2, 1628($t0)
    sw $t2, 1868($t0)
    sw $t2, 1884($t0)
    sw $t2, 2124($t0)
    sw $t2, 2128($t0)
    sw $t2, 2132($t0)
    sw $t2, 2136($t0)
    sw $t2, 2140($t0)

    lw $t2, score_color
    la $t0, pixels
    sw $t2, 588($t0)
    sw $t2, 592($t0)
    sw $t2, 596($t0)
    sw $t2, 600($t0)
    sw $t2, 604($t0)
    sw $t2, 844($t0)
    sw $t2, 860($t0)
    sw $t2, 1100($t0)
    sw $t2, 1116($t0)
    sw $t2, 1356($t0)
    sw $t2, 1360($t0)
    sw $t2, 1364($t0)
    sw $t2, 1368($t0)
    sw $t2, 1372($t0)
    sw $t2, 1628($t0)
    sw $t2, 1884($t0)
    sw $t2, 2124($t0)
    sw $t2, 2128($t0)
    sw $t2, 2132($t0)
    sw $t2, 2136($t0)
    sw $t2, 2140($t0)

    j dozen_digit_of_score

dozen_digit_of_score:

    beq $t4, 0, draw_zero_dozen_score
    beq $t4, 1, draw_one_dozen_score
    beq $t4, 2, draw_two_dozen_score
    beq $t4, 3, draw_three_dozen_score
    beq $t4, 4, draw_four_dozen_score
    beq $t4, 5, draw_five_dozen_score
    beq $t4, 6, draw_six_dozen_score
    beq $t4, 7, draw_seven_dozen_score
    beq $t4, 8, draw_eight_dozen_score
    beq $t4, 9, draw_nine_dozen_score


draw_zero_dozen_score:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 564($t0)
    sw $t2, 568($t0)
    sw $t2, 572($t0)
    sw $t2, 576($t0)
    sw $t2, 580($t0)
    sw $t2, 820($t0)
    sw $t2, 836($t0)
    sw $t2, 1076($t0)
    sw $t2, 1092($t0)
    sw $t2, 1332($t0)
    sw $t2, 1336($t0)
    sw $t2, 1340($t0)
    sw $t2, 1344($t0)
    sw $t2, 1348($t0)
    sw $t2, 1604($t0)
    sw $t2, 1860($t0)
    sw $t2, 2100($t0)
    sw $t2, 2104($t0)
    sw $t2, 2108($t0)
    sw $t2, 2112($t0)
    sw $t2, 2116($t0)

    lw $t2, score_color
    la $t0, pixels
    sw $t2, 564($t0)
    sw $t2, 568($t0)
    sw $t2, 572($t0)
    sw $t2, 576($t0)
    sw $t2, 580($t0)
    sw $t2, 820($t0) 
    sw $t2, 836($t0)
    sw $t2, 1076($t0)
    sw $t2, 1092($t0)
    sw $t2, 1332($t0)
    sw $t2, 1348($t0)
    sw $t2, 1588($t0)
    sw $t2, 1604($t0)
    sw $t2, 1844($t0)
    sw $t2, 1860($t0)
    sw $t2, 2100($t0)
    sw $t2, 2104($t0)
    sw $t2, 2108($t0)
    sw $t2, 2112($t0)
    sw $t2, 2116($t0)

    jr $ra

draw_one_dozen_score:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 564($t0)
    sw $t2, 568($t0)
    sw $t2, 572($t0)
    sw $t2, 576($t0)
    sw $t2, 580($t0)
    sw $t2, 820($t0) 
    sw $t2, 836($t0)
    sw $t2, 1076($t0)
    sw $t2, 1092($t0)
    sw $t2, 1332($t0)
    sw $t2, 1348($t0)
    sw $t2, 1588($t0)
    sw $t2, 1604($t0)
    sw $t2, 1844($t0)
    sw $t2, 1860($t0)
    sw $t2, 2100($t0)
    sw $t2, 2104($t0)
    sw $t2, 2108($t0)
    sw $t2, 2112($t0)
    sw $t2, 2116($t0)

    lw $t2, score_color
    la $t0, pixels
    sw $t2, 580($t0)
    sw $t2, 836($t0)
    sw $t2, 1092($t0)
    sw $t2, 1348($t0)
    sw $t2, 1604($t0)
    sw $t2, 1860($t0)
    sw $t2, 2116($t0)

    jr $ra

draw_two_dozen_score:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 580($t0)
    sw $t2, 836($t0)
    sw $t2, 1092($t0)
    sw $t2, 1348($t0)
    sw $t2, 1604($t0)
    sw $t2, 1860($t0)
    sw $t2, 2116($t0)

    lw $t2, score_color
    la $t0, pixels
    sw $t2, 564($t0)
    sw $t2, 568($t0)
    sw $t2, 572($t0)
    sw $t2, 576($t0)
    sw $t2, 580($t0)
    sw $t2, 836($t0)
    sw $t2, 1092($t0)
    sw $t2, 1332($t0)
    sw $t2, 1336($t0)
    sw $t2, 1340($t0)
    sw $t2, 1344($t0)
    sw $t2, 1348($t0)
    sw $t2, 1588($t0)
    sw $t2, 1844($t0)
    sw $t2, 2100($t0)
    sw $t2, 2104($t0)
    sw $t2, 2108($t0)
    sw $t2, 2112($t0)
    sw $t2, 2116($t0)

    jr $ra

draw_three_dozen_score:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 564($t0)
    sw $t2, 568($t0)
    sw $t2, 572($t0)
    sw $t2, 576($t0)
    sw $t2, 580($t0)
    sw $t2, 836($t0)
    sw $t2, 1092($t0)
    sw $t2, 1332($t0)
    sw $t2, 1336($t0)
    sw $t2, 1340($t0)
    sw $t2, 1344($t0)
    sw $t2, 1348($t0)
    sw $t2, 1588($t0)
    sw $t2, 1844($t0)
    sw $t2, 2100($t0)
    sw $t2, 2104($t0)
    sw $t2, 2108($t0)
    sw $t2, 2112($t0)
    sw $t2, 2116($t0)

    lw $t2, score_color
    la $t0, pixels
    sw $t2, 564($t0)
    sw $t2, 568($t0)
    sw $t2, 572($t0)
    sw $t2, 576($t0)
    sw $t2, 580($t0)
    sw $t2, 836($t0)
    sw $t2, 1092($t0)
    sw $t2, 1332($t0)
    sw $t2, 1336($t0)
    sw $t2, 1340($t0)
    sw $t2, 1344($t0)
    sw $t2, 1348($t0)
    sw $t2, 1604($t0)
    sw $t2, 1860($t0)
    sw $t2, 2100($t0)
    sw $t2, 2104($t0)
    sw $t2, 2108($t0)
    sw $t2, 2112($t0)
    sw $t2, 2116($t0)

    jr $ra

draw_four_dozen_score:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 564($t0)
    sw $t2, 568($t0)
    sw $t2, 572($t0)
    sw $t2, 576($t0)
    sw $t2, 580($t0)
    sw $t2, 836($t0)
    sw $t2, 1092($t0)
    sw $t2, 1332($t0)
    sw $t2, 1336($t0)
    sw $t2, 1340($t0)
    sw $t2, 1344($t0)
    sw $t2, 1348($t0)
    sw $t2, 1604($t0)
    sw $t2, 1860($t0)
    sw $t2, 2100($t0)
    sw $t2, 2104($t0)
    sw $t2, 2108($t0)
    sw $t2, 2112($t0)
    sw $t2, 2116($t0)

    lw $t2, score_color
    la $t0, pixels
    sw $t2, 564($t0)
    sw $t2, 580($t0)
    sw $t2, 820($t0)
    sw $t2, 836($t0)
    sw $t2, 1076($t0)
    sw $t2, 1092($t0)
    sw $t2, 1332($t0)
    sw $t2, 1336($t0)
    sw $t2, 1340($t0)
    sw $t2, 1344($t0)
    sw $t2, 1348($t0)
    sw $t2, 1604($t0)
    sw $t2, 1860($t0)
    sw $t2, 2116($t0)

    jr $ra

draw_five_dozen_score:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 564($t0)
    sw $t2, 580($t0)
    sw $t2, 820($t0)
    sw $t2, 836($t0)
    sw $t2, 1076($t0)
    sw $t2, 1092($t0)
    sw $t2, 1332($t0)
    sw $t2, 1336($t0)
    sw $t2, 1340($t0)
    sw $t2, 1344($t0)
    sw $t2, 1348($t0)
    sw $t2, 1604($t0)
    sw $t2, 1860($t0)
    sw $t2, 2116($t0)

    lw $t2, score_color
    la $t0, pixels
    sw $t2, 564($t0)
    sw $t2, 568($t0)
    sw $t2, 572($t0)
    sw $t2, 576($t0)
    sw $t2, 580($t0)
    sw $t2, 820($t0)
    sw $t2, 1076($t0)
    sw $t2, 1332($t0)
    sw $t2, 1336($t0)
    sw $t2, 1340($t0)
    sw $t2, 1344($t0)
    sw $t2, 1348($t0)
    sw $t2, 1604($t0)
    sw $t2, 1860($t0)
    sw $t2, 2100($t0)
    sw $t2, 2104($t0)
    sw $t2, 2108($t0)
    sw $t2, 2112($t0)
    sw $t2, 2116($t0)

    jr $ra

draw_six_dozen_score:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 564($t0)
    sw $t2, 568($t0)
    sw $t2, 572($t0)
    sw $t2, 576($t0)
    sw $t2, 580($t0)
    sw $t2, 820($t0)
    sw $t2, 1076($t0)
    sw $t2, 1332($t0)
    sw $t2, 1336($t0)
    sw $t2, 1340($t0)
    sw $t2, 1344($t0)
    sw $t2, 1348($t0)
    sw $t2, 1604($t0)
    sw $t2, 1860($t0)
    sw $t2, 2100($t0)
    sw $t2, 2104($t0)
    sw $t2, 2108($t0)
    sw $t2, 2112($t0)
    sw $t2, 2116($t0)

    lw $t2, score_color
    la $t0, pixels
    sw $t2, 564($t0)
    sw $t2, 568($t0)
    sw $t2, 572($t0)
    sw $t2, 576($t0)
    sw $t2, 580($t0)
    sw $t2, 820($t0)
    sw $t2, 1076($t0)
    sw $t2, 1332($t0)
    sw $t2, 1336($t0)
    sw $t2, 1340($t0)
    sw $t2, 1344($t0)
    sw $t2, 1348($t0)
    sw $t2, 1588($t0)
    sw $t2, 1604($t0)
    sw $t2, 1844($t0)
    sw $t2, 1860($t0)
    sw $t2, 2100($t0)
    sw $t2, 2104($t0)
    sw $t2, 2108($t0)
    sw $t2, 2112($t0)
    sw $t2, 2116($t0)

    jr $ra

draw_seven_dozen_score:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 564($t0)
    sw $t2, 568($t0)
    sw $t2, 572($t0)
    sw $t2, 576($t0)
    sw $t2, 580($t0)
    sw $t2, 820($t0)
    sw $t2, 1076($t0)
    sw $t2, 1332($t0)
    sw $t2, 1336($t0)
    sw $t2, 1340($t0)
    sw $t2, 1344($t0)
    sw $t2, 1348($t0)
    sw $t2, 1588($t0)
    sw $t2, 1604($t0)
    sw $t2, 1844($t0)
    sw $t2, 1860($t0)
    sw $t2, 2100($t0)
    sw $t2, 2104($t0)
    sw $t2, 2108($t0)
    sw $t2, 2112($t0)
    sw $t2, 2116($t0)

    lw $t2, score_color
    la $t0, pixels
    sw $t2, 564($t0)
    sw $t2, 568($t0)
    sw $t2, 572($t0)
    sw $t2, 576($t0)
    sw $t2, 580($t0)
    sw $t2, 836($t0)
    sw $t2, 1092($t0)
    sw $t2, 1348($t0)
    sw $t2, 1604($t0)
    sw $t2, 1860($t0)
    sw $t2, 2116($t0)

    jr $ra

draw_eight_dozen_score:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 564($t0)
    sw $t2, 568($t0)
    sw $t2, 572($t0)
    sw $t2, 576($t0)
    sw $t2, 580($t0)
    sw $t2, 836($t0)
    sw $t2, 1092($t0)
    sw $t2, 1348($t0)
    sw $t2, 1604($t0)
    sw $t2, 1860($t0)
    sw $t2, 2116($t0)

    lw $t2, score_color
    la $t0, pixels
    sw $t2, 564($t0)
    sw $t2, 568($t0)
    sw $t2, 572($t0)
    sw $t2, 576($t0)
    sw $t2, 580($t0)
    sw $t2, 820($t0)
    sw $t2, 836($t0)
    sw $t2, 1076($t0)
    sw $t2, 1092($t0)
    sw $t2, 1332($t0)
    sw $t2, 1336($t0)
    sw $t2, 1340($t0)
    sw $t2, 1344($t0)
    sw $t2, 1348($t0)
    sw $t2, 1588($t0)
    sw $t2, 1604($t0)
    sw $t2, 1844($t0)
    sw $t2, 1860($t0)
    sw $t2, 2100($t0)
    sw $t2, 2104($t0)
    sw $t2, 2108($t0)
    sw $t2, 2112($t0)
    sw $t2, 2116($t0)

    jr $ra

draw_nine_dozen_score:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 564($t0)
    sw $t2, 568($t0)
    sw $t2, 572($t0)
    sw $t2, 576($t0)
    sw $t2, 580($t0)
    sw $t2, 820($t0)
    sw $t2, 836($t0)
    sw $t2, 1076($t0)
    sw $t2, 1092($t0)
    sw $t2, 1332($t0)
    sw $t2, 1336($t0)
    sw $t2, 1340($t0)
    sw $t2, 1344($t0)
    sw $t2, 1348($t0)
    sw $t2, 1588($t0)
    sw $t2, 1604($t0)
    sw $t2, 1844($t0)
    sw $t2, 1860($t0)
    sw $t2, 2100($t0)
    sw $t2, 2104($t0)
    sw $t2, 2108($t0)
    sw $t2, 2112($t0)
    sw $t2, 2116($t0)

    lw $t2, score_color
    la $t0, pixels
    sw $t2, 564($t0)
    sw $t2, 568($t0)
    sw $t2, 572($t0)
    sw $t2, 576($t0)
    sw $t2, 580($t0)
    sw $t2, 820($t0)
    sw $t2, 836($t0)
    sw $t2, 1076($t0)
    sw $t2, 1092($t0)
    sw $t2, 1332($t0)
    sw $t2, 1336($t0)
    sw $t2, 1340($t0)
    sw $t2, 1344($t0)
    sw $t2, 1348($t0)
    sw $t2, 1604($t0)
    sw $t2, 1860($t0)
    sw $t2, 2100($t0)
    sw $t2, 2104($t0)
    sw $t2, 2108($t0)
    sw $t2, 2112($t0)
    sw $t2, 2116($t0)

    jr $ra

update_highscore:

    blt $s6, $s0, increment_highscore # se a pontuacao do jogador for maior que a pontuacao recorde, atualiza o recorde

    jr $ra

increment_highscore:

    addi $s6, $s6, 1 # incrementa o recorde
    
draw_highscore:

    move $t0, $s6
    li $t1, 10

    div $t0, $t1
    mfhi $t3
    mflo $t4

unit_digit_of_highscore:

    beq $t3, 0, draw_zero_unit_highscore
    beq $t3, 1, draw_one_unit_highscore
    beq $t3, 2, draw_two_unit_highscore
    beq $t3, 3, draw_three_unit_highscore
    beq $t3, 4, draw_four_unit_highscore
    beq $t3, 5, draw_five_unit_highscore
    beq $t3, 6, draw_six_unit_highscore
    beq $t3, 7, draw_seven_unit_highscore
    beq $t3, 8, draw_eight_unit_highscore
    beq $t3, 9, draw_nine_unit_highscore

draw_zero_unit_highscore:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 692($t0)
    sw $t2, 696($t0)
    sw $t2, 700($t0)
    sw $t2, 704($t0)
    sw $t2, 708($t0)
    sw $t2, 948($t0)
    sw $t2, 964($t0)
    sw $t2, 1204($t0)
    sw $t2, 1220($t0)
    sw $t2, 1460($t0)
    sw $t2, 1464($t0)
    sw $t2, 1468($t0)
    sw $t2, 1472($t0)
    sw $t2, 1476($t0)
    sw $t2, 1732($t0)
    sw $t2, 1988($t0)
    sw $t2, 2228($t0)
    sw $t2, 2232($t0)
    sw $t2, 2236($t0)
    sw $t2, 2240($t0)
    sw $t2, 2244($t0)

    lw $t2, score_color
    la $t0, pixels
    sw $t2, 692($t0)
    sw $t2, 696($t0)
    sw $t2, 700($t0)
    sw $t2, 704($t0)
    sw $t2, 708($t0)
    sw $t2, 948($t0)
    sw $t2, 964($t0)
    sw $t2, 1204($t0)
    sw $t2, 1220($t0)
    sw $t2, 1460($t0)
    sw $t2, 1476($t0)
    sw $t2, 1716($t0)
    sw $t2, 1732($t0)
    sw $t2, 1972($t0)
    sw $t2, 1988($t0)
    sw $t2, 2228($t0)
    sw $t2, 2232($t0)
    sw $t2, 2236($t0)
    sw $t2, 2240($t0)
    sw $t2, 2244($t0)

    j dozen_digit_of_highscore

draw_one_unit_highscore:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 692($t0)
    sw $t2, 696($t0)
    sw $t2, 700($t0)
    sw $t2, 704($t0)
    sw $t2, 708($t0)
    sw $t2, 948($t0)
    sw $t2, 964($t0)
    sw $t2, 1204($t0)
    sw $t2, 1220($t0)
    sw $t2, 1460($t0)
    sw $t2, 1476($t0)
    sw $t2, 1716($t0)
    sw $t2, 1732($t0)
    sw $t2, 1972($t0)
    sw $t2, 1988($t0)
    sw $t2, 2228($t0)
    sw $t2, 2232($t0)
    sw $t2, 2236($t0)
    sw $t2, 2240($t0)
    sw $t2, 2244($t0)
    
    lw $t2, score_color
    la $t0, pixels
    sw $t2, 708($t0)
    sw $t2, 964($t0)
    sw $t2, 1220($t0)
    sw $t2, 1476($t0)
    sw $t2, 1732($t0)
    sw $t2, 1988($t0)
    sw $t2, 2244($t0)

    j dozen_digit_of_highscore

draw_two_unit_highscore:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 708($t0)
    sw $t2, 964($t0)
    sw $t2, 1220($t0)
    sw $t2, 1476($t0)
    sw $t2, 1732($t0)
    sw $t2, 1988($t0)
    sw $t2, 2244($t0)
    
    lw $t2, score_color
    la $t0, pixels
    sw $t2, 692($t0)
    sw $t2, 696($t0)
    sw $t2, 700($t0)
    sw $t2, 704($t0)
    sw $t2, 708($t0)
    sw $t2, 964($t0)
    sw $t2, 1220($t0)
    sw $t2, 1460($t0)
    sw $t2, 1464($t0)
    sw $t2, 1468($t0)
    sw $t2, 1472($t0)
    sw $t2, 1476($t0)
    sw $t2, 1716($t0)
    sw $t2, 1972($t0)
    sw $t2, 2228($t0)
    sw $t2, 2232($t0)
    sw $t2, 2236($t0)
    sw $t2, 2240($t0)
    sw $t2, 2244($t0)

    j dozen_digit_of_highscore

draw_three_unit_highscore:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 692($t0)
    sw $t2, 696($t0)
    sw $t2, 700($t0)
    sw $t2, 704($t0)
    sw $t2, 708($t0)
    sw $t2, 964($t0)
    sw $t2, 1220($t0)
    sw $t2, 1460($t0)
    sw $t2, 1464($t0)
    sw $t2, 1468($t0)
    sw $t2, 1472($t0)
    sw $t2, 1476($t0)
    sw $t2, 1716($t0)
    sw $t2, 1972($t0)
    sw $t2, 2228($t0)
    sw $t2, 2232($t0)
    sw $t2, 2236($t0)
    sw $t2, 2240($t0)
    sw $t2, 2244($t0)
    
    lw $t2, score_color
    la $t0, pixels
    sw $t2, 692($t0)
    sw $t2, 696($t0)
    sw $t2, 700($t0)
    sw $t2, 704($t0)
    sw $t2, 708($t0)
    sw $t2, 964($t0)
    sw $t2, 1220($t0)
    sw $t2, 1460($t0)
    sw $t2, 1464($t0)
    sw $t2, 1468($t0)
    sw $t2, 1472($t0)
    sw $t2, 1476($t0)
    sw $t2, 1732($t0)
    sw $t2, 1988($t0)
    sw $t2, 2228($t0)
    sw $t2, 2232($t0)
    sw $t2, 2236($t0)
    sw $t2, 2240($t0)
    sw $t2, 2244($t0)

    j dozen_digit_of_highscore

draw_four_unit_highscore:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 692($t0)
    sw $t2, 696($t0)
    sw $t2, 700($t0)
    sw $t2, 704($t0)
    sw $t2, 708($t0)
    sw $t2, 964($t0)
    sw $t2, 1220($t0)
    sw $t2, 1460($t0)
    sw $t2, 1464($t0)
    sw $t2, 1468($t0)
    sw $t2, 1472($t0)
    sw $t2, 1476($t0)
    sw $t2, 1732($t0)
    sw $t2, 1988($t0)
    sw $t2, 2228($t0)
    sw $t2, 2232($t0)
    sw $t2, 2236($t0)
    sw $t2, 2240($t0)
    sw $t2, 2244($t0)
    
    lw $t2, score_color
    la $t0, pixels
    sw $t2, 692($t0)
    sw $t2, 708($t0)
    sw $t2, 948($t0)
    sw $t2, 964($t0)
    sw $t2, 1204($t0)
    sw $t2, 1220($t0)
    sw $t2, 1460($t0)
    sw $t2, 1464($t0)
    sw $t2, 1468($t0)
    sw $t2, 1472($t0)
    sw $t2, 1476($t0)
    sw $t2, 1732($t0)
    sw $t2, 1988($t0)
    sw $t2, 2244($t0)

    j dozen_digit_of_highscore

draw_five_unit_highscore:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 692($t0)
    sw $t2, 708($t0)
    sw $t2, 948($t0)
    sw $t2, 964($t0)
    sw $t2, 1204($t0)
    sw $t2, 1220($t0)
    sw $t2, 1460($t0)
    sw $t2, 1464($t0)
    sw $t2, 1468($t0)
    sw $t2, 1472($t0)
    sw $t2, 1476($t0)
    sw $t2, 1732($t0)
    sw $t2, 1988($t0)
    sw $t2, 2244($t0)

    lw $t2, score_color
    la $t0, pixels
    sw $t2, 692($t0)
    sw $t2, 696($t0)
    sw $t2, 700($t0)
    sw $t2, 704($t0)
    sw $t2, 708($t0)
    sw $t2, 948($t0)
    sw $t2, 1204($t0)
    sw $t2, 1460($t0)
    sw $t2, 1464($t0)
    sw $t2, 1468($t0)
    sw $t2, 1472($t0)
    sw $t2, 1476($t0)
    sw $t2, 1732($t0)
    sw $t2, 1988($t0)
    sw $t2, 2228($t0)
    sw $t2, 2232($t0)
    sw $t2, 2236($t0)
    sw $t2, 2240($t0)
    sw $t2, 2244($t0)

    j dozen_digit_of_highscore

draw_six_unit_highscore:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 692($t0)
    sw $t2, 696($t0)
    sw $t2, 700($t0)
    sw $t2, 704($t0)
    sw $t2, 708($t0)
    sw $t2, 948($t0)
    sw $t2, 1204($t0)
    sw $t2, 1460($t0)
    sw $t2, 1464($t0)
    sw $t2, 1468($t0)
    sw $t2, 1472($t0)
    sw $t2, 1476($t0)
    sw $t2, 1732($t0)
    sw $t2, 1988($t0)
    sw $t2, 2228($t0)
    sw $t2, 2232($t0)
    sw $t2, 2236($t0)
    sw $t2, 2240($t0)
    sw $t2, 2244($t0)

    lw $t2, score_color
    la $t0, pixels
    sw $t2, 692($t0)
    sw $t2, 696($t0)
    sw $t2, 700($t0)
    sw $t2, 704($t0)
    sw $t2, 708($t0)
    sw $t2, 948($t0)
    sw $t2, 1204($t0)
    sw $t2, 1460($t0)
    sw $t2, 1464($t0)
    sw $t2, 1468($t0)
    sw $t2, 1472($t0)
    sw $t2, 1476($t0)
    sw $t2, 1716($t0)
    sw $t2, 1732($t0)
    sw $t2, 1972($t0)
    sw $t2, 1988($t0)
    sw $t2, 2228($t0)
    sw $t2, 2232($t0)
    sw $t2, 2236($t0)
    sw $t2, 2240($t0)
    sw $t2, 2244($t0)

    j dozen_digit_of_highscore

draw_seven_unit_highscore:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 692($t0)
    sw $t2, 696($t0)
    sw $t2, 700($t0)
    sw $t2, 704($t0)
    sw $t2, 708($t0)
    sw $t2, 948($t0)
    sw $t2, 1204($t0)
    sw $t2, 1460($t0)
    sw $t2, 1464($t0)
    sw $t2, 1468($t0)
    sw $t2, 1472($t0)
    sw $t2, 1476($t0)
    sw $t2, 1716($t0)
    sw $t2, 1732($t0)
    sw $t2, 1972($t0)
    sw $t2, 1988($t0)
    sw $t2, 2228($t0)
    sw $t2, 2232($t0)
    sw $t2, 2236($t0)
    sw $t2, 2240($t0)
    sw $t2, 2244($t0)

    lw $t2, score_color
    la $t0, pixels
    sw $t2, 692($t0)
    sw $t2, 696($t0)
    sw $t2, 700($t0)
    sw $t2, 704($t0)
    sw $t2, 708($t0)
    sw $t2, 964($t0)
    sw $t2, 1220($t0)
    sw $t2, 1476($t0)
    sw $t2, 1732($t0)
    sw $t2, 1988($t0)
    sw $t2, 2244($t0)

    j dozen_digit_of_score

draw_eight_unit_highscore:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 692($t0)
    sw $t2, 696($t0)
    sw $t2, 700($t0)
    sw $t2, 704($t0)
    sw $t2, 708($t0)
    sw $t2, 964($t0)
    sw $t2, 1220($t0)
    sw $t2, 1476($t0)
    sw $t2, 1732($t0)
    sw $t2, 1988($t0)
    sw $t2, 2244($t0)

    lw $t2, score_color
    la $t0, pixels
    sw $t2, 692($t0)
    sw $t2, 696($t0)
    sw $t2, 700($t0)
    sw $t2, 704($t0)
    sw $t2, 708($t0)
    sw $t2, 948($t0)
    sw $t2, 964($t0)
    sw $t2, 1204($t0)
    sw $t2, 1220($t0)
    sw $t2, 1460($t0)
    sw $t2, 1464($t0)
    sw $t2, 1468($t0)
    sw $t2, 1472($t0)
    sw $t2, 1476($t0)
    sw $t2, 1716($t0)
    sw $t2, 1732($t0)
    sw $t2, 1972($t0)
    sw $t2, 1988($t0)
    sw $t2, 2228($t0)
    sw $t2, 2232($t0)
    sw $t2, 2236($t0)
    sw $t2, 2240($t0)
    sw $t2, 2244($t0)

    j dozen_digit_of_highscore

draw_nine_unit_highscore:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 692($t0)
    sw $t2, 696($t0)
    sw $t2, 700($t0)
    sw $t2, 704($t0)
    sw $t2, 708($t0)
    sw $t2, 948($t0)
    sw $t2, 964($t0)
    sw $t2, 1204($t0)
    sw $t2, 1220($t0)
    sw $t2, 1460($t0)
    sw $t2, 1464($t0)
    sw $t2, 1468($t0)
    sw $t2, 1472($t0)
    sw $t2, 1476($t0)
    sw $t2, 1716($t0)
    sw $t2, 1732($t0)
    sw $t2, 1972($t0)
    sw $t2, 1988($t0)
    sw $t2, 2228($t0)
    sw $t2, 2232($t0)
    sw $t2, 2236($t0)
    sw $t2, 2240($t0)
    sw $t2, 2244($t0)

    lw $t2, score_color
    la $t0, pixels
    sw $t2, 692($t0)
    sw $t2, 696($t0)
    sw $t2, 700($t0)
    sw $t2, 704($t0)
    sw $t2, 708($t0)
    sw $t2, 948($t0)
    sw $t2, 964($t0)
    sw $t2, 1204($t0)
    sw $t2, 1220($t0)
    sw $t2, 1460($t0)
    sw $t2, 1464($t0)
    sw $t2, 1468($t0)
    sw $t2, 1472($t0)
    sw $t2, 1476($t0)
    sw $t2, 1732($t0)
    sw $t2, 1988($t0)
    sw $t2, 2228($t0)
    sw $t2, 2232($t0)
    sw $t2, 2236($t0)
    sw $t2, 2240($t0)
    sw $t2, 2244($t0)

    j dozen_digit_of_highscore


dozen_digit_of_highscore:

    beq $t4, 0, draw_zero_dozen_highscore
    beq $t4, 1, draw_one_dozen_highscore
    beq $t4, 2, draw_two_dozen_highscore
    beq $t4, 3, draw_three_dozen_highscore
    beq $t4, 4, draw_four_dozen_highscore
    beq $t4, 5, draw_five_dozen_highscore
    beq $t4, 6, draw_six_dozen_highscore
    beq $t4, 7, draw_seven_dozen_highscore
    beq $t4, 8, draw_eight_dozen_highscore
    beq $t4, 9, draw_nine_dozen_highscore


draw_zero_dozen_highscore:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 668($t0)
    sw $t2, 672($t0)
    sw $t2, 676($t0)
    sw $t2, 680($t0)
    sw $t2, 684($t0)
    sw $t2, 924($t0)
    sw $t2, 940($t0)
    sw $t2, 1180($t0)
    sw $t2, 1196($t0)
    sw $t2, 1436($t0)
    sw $t2, 1440($t0)
    sw $t2, 1444($t0)
    sw $t2, 1448($t0)
    sw $t2, 1452($t0)
    sw $t2, 1708($t0)
    sw $t2, 1964($t0)
    sw $t2, 2204($t0)
    sw $t2, 2208($t0)
    sw $t2, 2212($t0)
    sw $t2, 2216($t0)
    sw $t2, 2220($t0)

    lw $t2, score_color
    la $t0, pixels
    sw $t2, 668($t0)
    sw $t2, 672($t0)
    sw $t2, 676($t0)
    sw $t2, 680($t0)
    sw $t2, 684($t0)
    sw $t2, 924($t0)
    sw $t2, 940($t0)
    sw $t2, 1180($t0)
    sw $t2, 1196($t0)
    sw $t2, 1436($t0)
    sw $t2, 1452($t0)
    sw $t2, 1692($t0)
    sw $t2, 1708($t0)
    sw $t2, 1948($t0)
    sw $t2, 1964($t0)
    sw $t2, 2204($t0)
    sw $t2, 2208($t0)
    sw $t2, 2212($t0)
    sw $t2, 2216($t0)
    sw $t2, 2220($t0)

    jr $ra

draw_one_dozen_highscore:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 668($t0)
    sw $t2, 672($t0)
    sw $t2, 676($t0)
    sw $t2, 680($t0)
    sw $t2, 684($t0)
    sw $t2, 924($t0)
    sw $t2, 940($t0)
    sw $t2, 1180($t0)
    sw $t2, 1196($t0)
    sw $t2, 1436($t0)
    sw $t2, 1452($t0)
    sw $t2, 1692($t0)
    sw $t2, 1708($t0)
    sw $t2, 1948($t0)
    sw $t2, 1964($t0)
    sw $t2, 2204($t0)
    sw $t2, 2208($t0)
    sw $t2, 2212($t0)
    sw $t2, 2216($t0)
    sw $t2, 2220($t0)

    lw $t2, score_color
    la $t0, pixels
    sw $t2, 684($t0)
    sw $t2, 940($t0)
    sw $t2, 1196($t0)
    sw $t2, 1452($t0)
    sw $t2, 1708($t0)
    sw $t2, 1964($t0)
    sw $t2, 2220($t0)

    jr $ra

draw_two_dozen_highscore:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 684($t0)
    sw $t2, 940($t0)
    sw $t2, 1196($t0)
    sw $t2, 1452($t0)
    sw $t2, 1708($t0)
    sw $t2, 1964($t0)
    sw $t2, 2220($t0)

    lw $t2, score_color
    la $t0, pixels
    sw $t2, 668($t0)
    sw $t2, 672($t0)
    sw $t2, 676($t0)
    sw $t2, 680($t0)
    sw $t2, 684($t0)
    sw $t2, 940($t0)
    sw $t2, 1196($t0)
    sw $t2, 1436($t0)
    sw $t2, 1440($t0)
    sw $t2, 1444($t0)
    sw $t2, 1448($t0)
    sw $t2, 1452($t0)
    sw $t2, 1692($t0)
    sw $t2, 1948($t0)
    sw $t2, 2204($t0)
    sw $t2, 2208($t0)
    sw $t2, 2212($t0)
    sw $t2, 2216($t0)
    sw $t2, 2220($t0)

    jr $ra

draw_three_dozen_highscore:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 668($t0)
    sw $t2, 672($t0)
    sw $t2, 676($t0)
    sw $t2, 680($t0)
    sw $t2, 684($t0)
    sw $t2, 940($t0)
    sw $t2, 1196($t0)
    sw $t2, 1436($t0)
    sw $t2, 1440($t0)
    sw $t2, 1444($t0)
    sw $t2, 1448($t0)
    sw $t2, 1452($t0)
    sw $t2, 1692($t0)
    sw $t2, 1948($t0)
    sw $t2, 2204($t0)
    sw $t2, 2208($t0)
    sw $t2, 2212($t0)
    sw $t2, 2216($t0)
    sw $t2, 2220($t0)

    lw $t2, score_color
    la $t0, pixels
    sw $t2, 668($t0)
    sw $t2, 672($t0)
    sw $t2, 676($t0)
    sw $t2, 680($t0)
    sw $t2, 684($t0)
    sw $t2, 940($t0)
    sw $t2, 1196($t0)
    sw $t2, 1436($t0)
    sw $t2, 1440($t0)
    sw $t2, 1444($t0)
    sw $t2, 1448($t0)
    sw $t2, 1452($t0)
    sw $t2, 1708($t0)
    sw $t2, 1964($t0)
    sw $t2, 2204($t0)
    sw $t2, 2208($t0)
    sw $t2, 2212($t0)
    sw $t2, 2216($t0)
    sw $t2, 2220($t0)

    jr $ra

draw_four_dozen_highscore:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 668($t0)
    sw $t2, 672($t0)
    sw $t2, 676($t0)
    sw $t2, 680($t0)
    sw $t2, 684($t0)
    sw $t2, 940($t0)
    sw $t2, 1196($t0)
    sw $t2, 1436($t0)
    sw $t2, 1440($t0)
    sw $t2, 1444($t0)
    sw $t2, 1448($t0)
    sw $t2, 1452($t0)
    sw $t2, 1708($t0)
    sw $t2, 1964($t0)
    sw $t2, 2204($t0)
    sw $t2, 2208($t0)
    sw $t2, 2212($t0)
    sw $t2, 2216($t0)
    sw $t2, 2220($t0)

    lw $t2, score_color
    la $t0, pixels
    sw $t2, 668($t0)
    sw $t2, 684($t0)
    sw $t2, 924($t0)
    sw $t2, 940($t0)
    sw $t2, 1180($t0)
    sw $t2, 1196($t0)
    sw $t2, 1436($t0)
    sw $t2, 1440($t0)
    sw $t2, 1444($t0)
    sw $t2, 1448($t0)
    sw $t2, 1452($t0)
    sw $t2, 1708($t0)
    sw $t2, 1964($t0)
    sw $t2, 2220($t0)

    jr $ra

draw_five_dozen_highscore:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 668($t0)
    sw $t2, 684($t0)
    sw $t2, 924($t0)
    sw $t2, 940($t0)
    sw $t2, 1180($t0)
    sw $t2, 1196($t0)
    sw $t2, 1436($t0)
    sw $t2, 1440($t0)
    sw $t2, 1444($t0)
    sw $t2, 1448($t0)
    sw $t2, 1452($t0)
    sw $t2, 1708($t0)
    sw $t2, 1964($t0)
    sw $t2, 2220($t0)

    lw $t2, score_color
    la $t0, pixels
    sw $t2, 668($t0)
    sw $t2, 672($t0)
    sw $t2, 676($t0)
    sw $t2, 680($t0)
    sw $t2, 684($t0)
    sw $t2, 924($t0)
    sw $t2, 1180($t0)
    sw $t2, 1436($t0)
    sw $t2, 1440($t0)
    sw $t2, 1444($t0)
    sw $t2, 1448($t0)
    sw $t2, 1452($t0)
    sw $t2, 1708($t0)
    sw $t2, 1964($t0)
    sw $t2, 2204($t0)
    sw $t2, 2208($t0)
    sw $t2, 2212($t0)
    sw $t2, 2216($t0)
    sw $t2, 2220($t0)

    jr $ra

draw_six_dozen_highscore:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 668($t0)
    sw $t2, 672($t0)
    sw $t2, 676($t0)
    sw $t2, 680($t0)
    sw $t2, 684($t0)
    sw $t2, 924($t0)
    sw $t2, 1180($t0)
    sw $t2, 1436($t0)
    sw $t2, 1440($t0)
    sw $t2, 1444($t0)
    sw $t2, 1448($t0)
    sw $t2, 1452($t0)
    sw $t2, 1708($t0)
    sw $t2, 1964($t0)
    sw $t2, 2204($t0)
    sw $t2, 2208($t0)
    sw $t2, 2212($t0)
    sw $t2, 2216($t0)
    sw $t2, 2220($t0)

    lw $t2, score_color
    la $t0, pixels
    sw $t2, 668($t0)
    sw $t2, 672($t0)
    sw $t2, 676($t0)
    sw $t2, 680($t0)
    sw $t2, 684($t0)
    sw $t2, 924($t0)
    sw $t2, 1180($t0)
    sw $t2, 1436($t0)
    sw $t2, 1440($t0)
    sw $t2, 1444($t0)
    sw $t2, 1448($t0)
    sw $t2, 1452($t0)
    sw $t2, 1692($t0)
    sw $t2, 1708($t0)
    sw $t2, 1948($t0)
    sw $t2, 1964($t0)
    sw $t2, 2204($t0)
    sw $t2, 2208($t0)
    sw $t2, 2212($t0)
    sw $t2, 2216($t0)
    sw $t2, 2220($t0)

    jr $ra

draw_seven_dozen_highscore:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 668($t0)
    sw $t2, 672($t0)
    sw $t2, 676($t0)
    sw $t2, 680($t0)
    sw $t2, 684($t0)
    sw $t2, 924($t0)
    sw $t2, 1180($t0)
    sw $t2, 1436($t0)
    sw $t2, 1440($t0)
    sw $t2, 1444($t0)
    sw $t2, 1448($t0)
    sw $t2, 1452($t0)
    sw $t2, 1692($t0)
    sw $t2, 1708($t0)
    sw $t2, 1948($t0)
    sw $t2, 1964($t0)
    sw $t2, 2204($t0)
    sw $t2, 2208($t0)
    sw $t2, 2212($t0)
    sw $t2, 2216($t0)
    sw $t2, 2220($t0)

    lw $t2, score_color
    la $t0, pixels
    sw $t2, 668($t0)
    sw $t2, 672($t0)
    sw $t2, 676($t0)
    sw $t2, 680($t0)
    sw $t2, 684($t0)
    sw $t2, 940($t0)
    sw $t2, 1196($t0)
    sw $t2, 1452($t0)
    sw $t2, 1708($t0)
    sw $t2, 1964($t0)
    sw $t2, 2220($t0)

    jr $ra

draw_eight_dozen_highscore:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 668($t0)
    sw $t2, 672($t0)
    sw $t2, 676($t0)
    sw $t2, 680($t0)
    sw $t2, 684($t0)
    sw $t2, 940($t0)
    sw $t2, 1196($t0)
    sw $t2, 1452($t0)
    sw $t2, 1708($t0)
    sw $t2, 1964($t0)
    sw $t2, 2220($t0)

    lw $t2, score_color
    la $t0, pixels
    sw $t2, 668($t0)
    sw $t2, 672($t0)
    sw $t2, 676($t0)
    sw $t2, 680($t0)
    sw $t2, 684($t0)
    sw $t2, 924($t0)
    sw $t2, 940($t0)
    sw $t2, 1180($t0)
    sw $t2, 1196($t0)
    sw $t2, 1436($t0)
    sw $t2, 1440($t0)
    sw $t2, 1444($t0)
    sw $t2, 1448($t0)
    sw $t2, 1452($t0)
    sw $t2, 1692($t0)
    sw $t2, 1708($t0)
    sw $t2, 1948($t0)
    sw $t2, 1964($t0)
    sw $t2, 2204($t0)
    sw $t2, 2208($t0)
    sw $t2, 2212($t0)
    sw $t2, 2216($t0)
    sw $t2, 2220($t0)

    jr $ra

draw_nine_dozen_highscore:

    lw $t2, score_background_color
    la $t0, pixels
    sw $t2, 668($t0)
    sw $t2, 672($t0)
    sw $t2, 676($t0)
    sw $t2, 680($t0)
    sw $t2, 684($t0)
    sw $t2, 924($t0)
    sw $t2, 940($t0)
    sw $t2, 1180($t0)
    sw $t2, 1196($t0)
    sw $t2, 1436($t0)
    sw $t2, 1440($t0)
    sw $t2, 1444($t0)
    sw $t2, 1448($t0)
    sw $t2, 1452($t0)
    sw $t2, 1692($t0)
    sw $t2, 1708($t0)
    sw $t2, 1948($t0)
    sw $t2, 1964($t0)
    sw $t2, 2204($t0)
    sw $t2, 2208($t0)
    sw $t2, 2212($t0)
    sw $t2, 2216($t0)
    sw $t2, 2220($t0)

    lw $t2, score_color
    la $t0, pixels
    sw $t2, 668($t0)
    sw $t2, 672($t0)
    sw $t2, 676($t0)
    sw $t2, 680($t0)
    sw $t2, 684($t0)
    sw $t2, 924($t0)
    sw $t2, 940($t0)
    sw $t2, 1180($t0)
    sw $t2, 1196($t0)
    sw $t2, 1436($t0)
    sw $t2, 1440($t0)
    sw $t2, 1444($t0)
    sw $t2, 1448($t0)
    sw $t2, 1452($t0)
    sw $t2, 1708($t0)
    sw $t2, 1964($t0)
    sw $t2, 2204($t0)
    sw $t2, 2208($t0)
    sw $t2, 2212($t0)
    sw $t2, 2216($t0)
    sw $t2, 2220($t0)

    jr $ra

game_over:

    li $v0, 4   # syscall para imprimir uma string na tela
    la $a0, str_game_over       # string fim de jogo
    syscall

    li $v0, 1   # syscall para imprimir um inteiro na tela
    add $a0, $s0, $zero         # pontuacao do jogador
    syscall

    li $v0, 50 # prompt perguntando se o jogador quer jogar novamente
    la $a0, str_play_again
    syscall
    
    move $s3, $zero # reinicia a direcao da cobra
    beqz $a0, draw_board_background_color  # se o jogador desejar jogar novamente, o jogo reinicia

    li $v0, 10  # caso contrario o programa encerra
    syscall
