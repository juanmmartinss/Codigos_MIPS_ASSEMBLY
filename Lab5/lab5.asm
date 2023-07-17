.data
 
    printa: .asciiz "Entre com a string numerica:\n"
    emmorse: .asciiz "A string em codigo Morse eh:"
    string: .space 10000
    zero: .asciiz "- - - - -"
    one: .asciiz ". - - - -"
    two: .asciiz ". . - - -"
    three: .asciiz ". . . - -"
    four: .asciiz ". . . . -"
    five: .asciiz ". . . . ."
    six: .asciiz "- . . . ."
    seven: .asciiz "- - . . ."
    eight: .asciiz "- - - . ."
    nine: .asciiz "- - - - ."
    espaco: .asciiz " "
 
.text
 
main:
    #//mostra o print
    li $v0, 4
    la $a0, printa
    syscall
 
    #//le a string
    li $v0, 8
    la $a0, string
    li $a1, 10000
    syscall
 
    move $t1, $a0
 
    li $v0, 4
    la $a0, emmorse
    syscall   
 
pegaposicao:
    #//pega a posicao da string
 
    lb $t3, 0($t1)#//pega o valor da posicao da string
 
    beq $t3, 48, zeroprint
    beq $t3, 49, oneprint
    beq $t3, 50, twoprint
    beq $t3, 51, threeprint
    beq $t3, 52, fourprint
    beq $t3, 53, fiveprint
    beq $t3, 54, sixprint
    beq $t3, 55, sevenprint
    beq $t3, 56, eightprint
    beq $t3, 57, nineprint
    beq $t3, 32, ehespaco
 
    j fim
 
zeroprint:
    #//printa 
    li $v0, 4
    la $a0, espaco
    syscall
 
    li $v0, 4
    la $a0, zero
    syscall
 
    add $t1, $t1, 1
 
    j pegaposicao
 
oneprint:
 
    li $v0, 4
    la $a0, espaco
    syscall
 
    li $v0, 4
    la $a0, one
    syscall
 
    add $t1, $t1, 1
 
    j pegaposicao
 
 
twoprint:
    li $v0, 4
    la $a0, espaco
    syscall
 
    li $v0, 4
    la $a0, two
    syscall
 
    add $t1, $t1, 1
 
    j pegaposicao
 
threeprint:
    li $v0, 4
    la $a0, espaco
    syscall
 
    li $v0, 4
    la $a0, three
    syscall
 
    add $t1, $t1, 1
 
    j pegaposicao
 
fourprint:
    li $v0, 4
    la $a0, espaco
    syscall
 
    li $v0, 4
    la $a0, four
    syscall
 
    add $t1, $t1, 1
 
    j pegaposicao
 
fiveprint:
    li $v0, 4
    la $a0, espaco
    syscall
 
    li $v0, 4
    la $a0, five
    syscall
 
    add $t1, $t1, 1
 
    j pegaposicao
 
sixprint:
    li $v0, 4
    la $a0, espaco
    syscall
 
    li $v0, 4
    la $a0, six
    syscall
 
    add $t1, $t1, 1
 
    j pegaposicao
 
sevenprint:
    li $v0, 4
    la $a0, espaco
    syscall
 
    li $v0, 4
    la $a0, seven
    syscall
 
    add $t1, $t1, 1
 
    j pegaposicao
 
eightprint:
    li $v0, 4
    la $a0, espaco
    syscall
 
    li $v0, 4
    la $a0, eight
    syscall
 
    add $t1, $t1, 1
 
    j pegaposicao
 
nineprint:
    li $v0, 4
    la $a0, espaco
    syscall
 
    li $v0, 4
    la $a0, nine
    syscall
 
    add $t1, $t1, 1
 
    j pegaposicao

ehespaco:

    add $t1, $t1, 1
 
    j pegaposicao
    
fim:
    li $v0, 10
    syscall