.data

    iniciovet: .asciiz "Entre com a quantidade de numeros do vetor:\n"
    numerodovet: .asciiz "Entre com o numero "
    dovet: .asciiz " do vetor:\n"
    vetlido: .asciiz "Vetor lido: "
    medvar: .asciiz "\nA media e variancia do vetor sao: "
    virgula: .asciiz ", "
    espaco: .asciiz " "
    vetorlido: .asciiz "Vetor lido: "

.text 

main:

	li $v0, 4
   	la $a0, iniciovet
    	syscall
    
    	li $v0, 5
    	syscall
    
    	move $t0, $v0
    	move $t8, $v0
    	
    	li $s3, 4
    	mul $s2, $t0, $s3
    	
    	li $t1, 0
    	li $t3, 0
    	
    	sll $a0, $v0, 2
		
        li $v0, 9
	syscall
		
	move $t9, $v0
	move $t5, $v0
    	
	loopparanum:	
	
    		blt $t3, $t0, Somaum
    			
    		j finalcomp
  
    	Somaum:
    	
    		li $v0, 4
   		la $a0, numerodovet
    		syscall
    			
    		li $v0, 1
		move $a0, $t3
		syscall
			
		li $v0, 4
   		la $a0, dovet
    		syscall
    	
    		li $v0, 6
        	syscall
        	
        	add.s $f2, $f2, $f0 #pega a soma para fazer a divisao

        	swc1 $f0, 0($t5)
        	
        	addi $t5, $t5, 4 #passa para a proxima posicao do vetor
    		addi $t3, $t3, 1 #passa para o proximo indice
 
    		j loopparanum
    			
    	finalcomp:
    	
    		#li $v0, 2
		#mov.s $f12, $f2 #printa a soma(apenas para verificacao)
		#syscall
    		
    		li $v0, 4
   		la $a0, vetorlido
    		syscall
    		
    		move $t5, $t9
    		li $t3, 0
    		
    		imprime:
    		
    			beq $t3, $t0, saiimpressao
    			
    			li $v0, 2
    			lwc1 $f0, 0($t5)
    			mov.s $f12, $f0
    			syscall

			li $v0, 4
   			la $a0, espaco
    			syscall
    			
    			addi $t5, $t5, 4
    			addi $t3, $t3, 1
    			
    			j imprime

	saiimpressao:
	
		li $v0, 4
   		la $a0, medvar
    		syscall
    		
    		sub $t7, $t0, 1
    		
    		mtc1 $t7, $f17
    		cvt.s.w $f17, $f17
    		
    		mtc1 $t0, $f10
    		cvt.s.w $f10, $f10 #converte $t0 para float para conseguir fazer a divisao
		
		div.s $f6, $f2, $f10
    		
    		move $t5, $t9
    		li $t3, 0
    		
    		loopvar:
    		
    			beq $t3, $t0, saidoloop
    		
    			lwc1 $f0, 0($t5)
    			
    			sub.s $f22, $f0, $f6
    			mul.s $f21, $f22, $f22
    			add.s $f3, $f3, $f21
    			
    			addi $t5, $t5, 4
    			addi $t3, $t3, 1
    			
    			j loopvar
    			
    	saidoloop:
    	
    		li $v0, 2
		mov.s $f12, $f6
		syscall
		
		li $v0, 4
   		la $a0, virgula
    		syscall
    		
    		div.s $f15, $f3, $f17
    		
		li $v0, 2
		mov.s $f12, $f15
		syscall
