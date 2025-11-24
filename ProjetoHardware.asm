.data
frase1: .asciiz "UTILITARIO DE CRIPTOGRAFIA"
frase2: .asciiz "1 - CRIPTOGRAFAR"
frase4: .asciiz "1 - CIFRA DE CESAR"
frase5: .asciiz "2 - CIFRA DE ROT13"
frase6: .asciiz "3 - CIFRA XOR( Chave 7)"
frase7: .asciiz "Digite a opcao: "

msgTexto: .asciiz "Digite o texto para criptografar (max 31 chars): "
msgTextoD: .asciiz "Digite o texto para descriptografar (max 31 chars): "
msgResultado: .asciiz "Texto criptografado: "


buffer: .space 32
transformado: .space 32


.text
.globl main
main:

    
    
    

    criptografar:
    
    li $v0,4
    la $a0, frase4
    syscall
    
    li $v0,11
    li $a0,10
    syscall

    li $v0,4
    la $a0, frase5
    syscall
    
    li $v0,11
    li $a0,10
    syscall

    li $v0,4
    la $a0, frase6
    syscall
    
    li $v0,11
    li $a0,10
    syscall
    
    li $v0,4
    la $a0, frase7
    syscall
    
    li $v0,5
    syscall
    move $t0, $v0 
    
    beq $t0,1,cesar_cripto
    beq $t0,2,rot13_cripto
    beq $t0,3,xor_cripto
    
    j fim_do_codigo
    

cesar_cripto:

   
    li $v0,4
    la $a0, msgTexto
    syscall

 
    li $v0,8
    la $a0, buffer
    li $a1, 32
    syscall
    la $t4,buffer
    
    la $t4, buffer
    la $t5, transformado
    
cesar_loop_cripto:
    
    lb $t6,0($t4)
    beq $t6,$zero,cesar_fim
    li $t0,'x'
    beq $t6,$t0,x
    li $t0,'y'
    beq $t6,$t0,y
    li $t0,'z'
    beq $t6,$t0,z
    
    addi $t6,$t6,3
    sb $t6,0($t5)
    addi $t5,$t5,1
    addi $t4,$t4,1
    j cesar_loop_cripto
    
    x:
    li $t6,'a'
    sb $t6,0($t5)
    addi $t5,$t5,1
    addi $t4,$t4,1
    j cesar_loop_cripto
    
    y:
    li $t6,'b'
    sb $t6,0($t5)
    addi $t5,$t5,1
    addi $t4,$t4,1
    j cesar_loop_cripto
    
    z:
    li $t6,'c'
    sb $t6,0($t5)
    addi $t5,$t5,1
    addi $t4,$t4,1
    j cesar_loop_cripto
    
    
    cesar_fim:
    li $v0,4
    la $a0, msgResultado
    syscall
    
    
    li $v0,4
    la $a0,transformado
    syscall
    
    
    j fim_do_codigo
    
rot13_cripto:

    li $v0,4
    la $a0, msgTexto
    syscall
    li $v0,8
    la $a0, buffer
    li $a1, 32
    syscall
    
    la $t4,buffer  
    la $t5, transformado
    
rot13_loop_cripto:
    
    lb $t6,0($t4)
    beq $t6,$zero,rot13_fim
    addi $t6,$t6,13
    bgt $t6,'z',fora_intervalo
    
    sb $t6,0($t5)
    addi $t4,$t4,1
    addi $t5,$t5,1
    j rot13_loop_cripto 
    
    fora_intervalo:
    addi $t6,$t6,-26
    
    sb $t6,0($t5)
    addi $t4,$t4,1
    addi $t5,$t5,1
    j rot13_loop_cripto
    
    rot13_fim:
    la $a0,transformado
    li $v0,4
    syscall
    
    j fim_do_codigo
    
  xor_cripto:

    li $v0,4
    la $a0, msgTexto
    syscall
    
    li $v0,8
    la $a0, buffer
    li $a1, 32
    syscall
    la $t4,buffer
    la $t4,buffer 
    la $t5, transformado
    
    li $t0,7
cifra_xor_loop:
    
    lb $t6,0($t4)
    beq $t6,$zero,xor_fim
    xor $t6,$t6,$t0
    sb $t6,0($t5)
    addi $t4,$t4,1
    addi $t5,$t5,1  
    
    j cifra_xor_loop
        
    xor_fim:
    
    li $v0,4
    la $a0,transformado
    syscall
    
   j fim_do_codigo	
    
    fim_do_codigo:
    li $v0,10
    syscall

	


    

