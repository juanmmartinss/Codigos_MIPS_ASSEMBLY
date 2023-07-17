.data

    datainicio: .asciiz "Entre com a hora de inicio (HH):\n"
    horainvalida: .asciiz "Hora invalida.\n"
    minutoinicio: .asciiz "Entre o minuto de inicio (MM):\n"
    minutoinvalido: .asciiz "Minuto invalido.\n"
    horasduracao: .asciiz "Entre com as horas de duracao (HH):\n"
    horasinvalidas: .asciiz "Horas invalidas.\n"
    minutosduracao: .asciiz "Entre com os minutos de duracao (MM):\n"
    minutosinvalidos: .asciiz "Minutos invalidos.\n"
    horareuniao: .asciiz "Horario da reuniao: "
    doispontos: .asciiz ":"
    letraa: .asciiz " a "

.text

main:

    li $v0, 4
    la $a0, datainicio
    syscall
    
    li $v0, 5
    syscall
    
    move $t0, $v0
    
    li $t1, 23
    
    while:
        bgt $t0, $t1, Horainvalida
        blt $t0, $zero, Horainvalida
        j final
    
    Horainvalida:
        li $v0, 4
        la $a0, horainvalida
        syscall
        
        li $v0, 4
        la $a0, datainicio
        syscall
        
        li $v0, 5
        syscall
        
        move $t0, $v0
        
        j while
        
    final:

	li $v0, 4
   	la $a0, minutoinicio
   	syscall
    
    	li $v0, 5
    	syscall
    
    	move $t2, $v0
    
    	li $t1, 59
    	
    whiletres:
        bgt $t2, $t1, Minutoinvalido
        blt $t2, $zero, Minutoinvalido
        j finaltres
    
    Minutoinvalido:
        li $v0, 4
        la $a0, minutoinvalido
        syscall
        
        li $v0, 4
        la $a0, minutoinicio
        syscall
        
        li $v0, 5
        syscall
        
        move $t2, $v0
        
        j whiletres
        
   finaltres:
   
	li $v0, 4
    	la $a0, horasduracao
    	syscall
    
    	li $v0, 5
    	syscall
    
	move $t4, $v0
    
    	li $t3, 23
    	
    whileseis:
        bgt $t4, $t3, Horainvalidadois
        blt $t4, $zero, Horainvalidadois
        j finalseis
    
    Horainvalidadois:
        li $v0, 4
        la $a0, horasinvalidas
        syscall
        
        li $v0, 4
        la $a0, horasduracao
        syscall
        
        li $v0, 5
        syscall
        
        move $t4, $v0
        
        j whileseis
        
    finalseis:
    
	li $v0, 4
   	la $a0, minutosduracao
   	syscall
    
    	li $v0, 5
    	syscall
    
    	move $t6, $v0
    
    	li $t5, 59
    
    whileoito:
        bgt $t6, $t5, Minutoinvalidodois
        blt $t6, $zero, Minutoinvalidodois
        j finaloito
    
    Minutoinvalidodois:
        li $v0, 4
        la $a0, minutosinvalidos
        syscall
        
        li $v0, 4
        la $a0, minutosduracao
        syscall
        
        li $v0, 5
        syscall
        
        move $t6, $v0
        
        j whileoito
        
   finaloito:
   	
   	add $t7,$t2,$t6
   	
   	li $t9, 59
   	
   	bgt $t7, $t9, Somaum
   	blt $t7, $t9, Continua
   	
   Somaum:
   	addi $t3, $t0, 1
   	sub $t1, $t7, 60
   
   	j Passa
   	
   Continua:
	add $t3, $t0, $zero
	add $t5, $t6, $t2
	
	add $t1, $t7, $zero
		
   Passa:
   
   	add $s3, $t3, $t4
   	
   	bgt $s3, 24, Arrumahora
   	blt $s3, 24, Passadois
   	
   Arrumahora:
   	sub $s4, $s3, 24
   	
   	j Continuadois
   	
   Passadois:
   	
   	add $s4, $s3, $zero
   	
   Continuadois:
   	li $v0, 4
	la $a0, horareuniao
    	syscall
    	
   	blt $t0, 10, Colocazero
   	bge $t0, 10, Naocolocazero
   	
   Colocazero:
   	
   	li $v0, 1
	move $a0, $zero
	syscall
   	
   	li $v0, 1
	move $a0, $t0
	syscall
	
	j Vaiparaproxima
	
   Naocolocazero:
	li $v0, 1
	move $a0, $t0
	syscall
	
   Vaiparaproxima:
	li $v0, 4
	la $a0, doispontos
    	syscall
    	
    	blt $t2, 10, Colocazeromin
    	bge $t2, 10, Naocolocazeromin
    	
    Colocazeromin:
    	li $v0, 1
	move $a0, $zero
	syscall
   	
   	li $v0, 1
	move $a0, $t2
	syscall
	
	j Vaiparaproximadois
   
    Naocolocazeromin:
	
	li $v0, 1
	move $a0, $t2
	syscall
	
    Vaiparaproximadois:
	li $v0, 4
	la $a0, letraa
    	syscall
    	
    	blt $s4, 10, Colocazerodois
   	bge $s4, 10, Naocolocazerodois
   	
   Colocazerodois:
   	
   	li $v0, 1
	move $a0, $zero
	syscall
   	
   	li $v0, 1
	move $a0, $s4
	syscall
	
	j Vaiparaproximatres
	
   Naocolocazerodois:
	li $v0, 1
	move $a0, $s4
	syscall
	
   Vaiparaproximatres:
	
	li $v0, 4
	la $a0, doispontos
    	syscall
    	
    	blt $t1, 10, Colocazeromindois
    	bge $t1, 10, Naocolocazeromindois
    	
    Colocazeromindois:
    	li $v0, 1
	move $a0, $zero
	syscall
   	
   	li $v0, 1
	move $a0, $t1
	syscall
	
	j Vaiparaproximaquatro
   
    Naocolocazeromindois:
	
	li $v0, 1
	move $a0, $t1
	syscall
	
    Vaiparaproximaquatro:
