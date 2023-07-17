.data

    iniciosequencia: .asciiz "Entre com a quantidade de numeros da sequencia:\n"
    numeroinvalido: .asciiz "Entre com um valor maior que 0.\n"
    numerodaseq: .asciiz "Entre com o numero "
    daseq: .asciiz " da sequencia:\n"
    valmin: .asciiz "Valor minimo da sequencia: "
    valmed: .asciiz "\nValor medio da sequencia: "
    valmax: .asciiz "\nValor maximo da sequencia: "

.text 

main:
	li $v0, 4
   	la $a0, iniciosequencia
    	syscall
    
    	li $v0, 5
    	syscall
    
    	move $t0, $v0
    	move $t8, $v0
    	
    	li $t1, 1
    	
	while:
        	blt $t0, $t1, Numinvalido
        	j final
    
    	Numinvalido:
        	li $v0, 4
        	la $a0, numeroinvalido
        	syscall
        
        	li $v0, 4
        	la $a0, iniciosequencia
        	syscall
        
        	li $v0, 5
        	syscall
        
        	move $t0, $v0
        	move $t8, $v0
        
        	j while
        
    	final:
    		li $t3, 1
    		
    		li $t4, 10000
    		#li $t5, 0
    		li $t6, 0
    		
    	loopparanum:
    			
    		ble $t3, $t0, Somaum
    			
    		j finalcomp
  
    	Somaum:
    		li $v0, 4
   		la $a0, numerodaseq
    		syscall
    			
    		li $v0, 1
		move $a0, $t3
		syscall
			
		li $v0, 4
   		la $a0, daseq
    		syscall
    	
    		li $v0, 5
        	syscall
    			
    		add $t3, $t3, 1
    		
    		add $t6, $t6, $v0
    		
       		blt $v0, $t4, Guardamenor
    		bgt $v0, $t5, Guardamaior
    		
    		move $t5, $v0
    		
    		j loopparanum
    			
    		Guardamenor:
    			
    			move $t4, $v0
    			bgt $v0, $t5, Guardamaior
			j loopparanum
    			
    		Guardamaior:
    			move $t5, $v0
    			j loopparanum
    	finalcomp:
		
		div $t7, $t6, $t8

    		li $v0, 4
   		la $a0, valmin
    		syscall
    		
    		li $v0, 1
		move $a0, $t4
		syscall
		
		li $v0, 4
   		la $a0, valmed
    		syscall
    		
    		li $v0, 1
		move $a0, $t7
		syscall
		
		li $v0, 4
   		la $a0, valmax
    		syscall
    		
    		li $v0, 1
		move $a0, $t5
		syscall
	
