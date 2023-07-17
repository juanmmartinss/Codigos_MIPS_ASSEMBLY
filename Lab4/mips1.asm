.data

	menu: .asciiz "\n1 - Inserir elemento\n2 - Remover elemento\n3 - Sair\n"
	caso1: .asciiz "Valor a se inserir: \n"
	imprimefila: .asciiz "Fila atual: "
	espaco: .asciiz " "
	erro: .asciiz "Erro: fila vazia."

.text

antesmain:

	li $t1, 0
	
main:

	li $v0, 4
	la $a0, menu
        syscall
        
        li $v0, 5
        syscall
        
        beq $v0, 1, insere #insere um valor e printa a fila
        beq $v0, 2, remove #remove um o primeiro valor inserido, caso nao tenha nada apenas mostra o erro
        beq $v0, 3, sair #apenas sai do programa
        
insere:

	add $t1, $t1, 1 #variavel de controle
	
	li $v0, 4
	la $a0, caso1
        syscall
        
        li $v0, 5 #pede um valor do teclado do usuario
        syscall
        
        move $t0, $v0
        
        sw $t0, 0($sp)
        move $t6, $sp #pega o valor de $t5 antes de somar para poder printar os valores
        move $t7, $sp
       	sub $sp, $sp, 4
       	move $t8, $sp
        
        li $v0, 4
	la $a0, imprimefila
        syscall
        
        li $t3, 0 #seta como zero o registrador $t3, para poder fazer o loop
        
        imprime:
    		
    		beq $t3, $t1, saiimprime
    			
    		li $v0, 1
    		lw $a0, 0($t6) #printa os valores de tras para frente para ficar como uma fila
    		syscall

		li $v0, 4
   		la $a0, espaco
    		syscall
    			
    		addi $t6, $t6, 4 #subtrai 4 voltando os valores do vetor
    		addi $t3, $t3, 1
    			
    		j imprime
    		
    	saiimprime:
    	
    		j main

remove:

	beq $t1, 0, error #caso nao tenha elementos na fila, pula para mostrar a msg de erro
	
	sub $t1, $t1, 1
	
	li $v0, 4
	la $a0, imprimefila
        syscall
        
        li $t3, 0 #seta como zero o registrador $t3, para poder fazer o loop
	
	imprimedois:
    		
    		beq $t3, $t1, saiimprimedois
    			
    		li $v0, 1
    		lw $a0, 0($t7) #printa os valores de tras para frente para ficar como uma fila
    		syscall

		li $v0, 4
   		la $a0, espaco
    		syscall
    			
    		addi $t7, $t7, 4 #subtrai 4 voltando os valores do vetor
    		addi $t3, $t3, 1
    			
    		j imprimedois
    	
    	saiimprimedois:
    	
    		mul $t5, $t1, -4 #multiplica a variavel de controle por -4 para voltar para a posicao certa e printar caso tenha 2 ou mais remocoes seguidas
    		add $t7, $t7, $t5 #soma o valor antigo com a nova posicao da variavel para printar corretamente
    		j main

error:

	li $v0, 4
	la $a0, erro
        syscall
        
        j main
sair:
