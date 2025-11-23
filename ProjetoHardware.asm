.data
frase1: .asciiz "UTILITARIO DE CRIPTOGRAFIA"
frase2: .asciiz "1 - CRIPTOGRAFAR"
frase3: .asciiz "2 - DESCRIPTOGRAFAR"
frase4: .asciiz "1 - CIFRA DE CESAR"
frase5: .asciiz "2 - CIFRA DE ROT13"
frase6: .asciiz "3 - CIFRA XOR"
frase7: .asciiz "Digite a opcao: "

msgTexto: .asciiz "Digite o texto para criptografar (max 31 chars): "
msgTextoD: .asciiz "Digite o texto para descriptografar (max 31 chars): "
msgResultado: .asciiz "Texto criptografado: "
msgResultadoD: .asciiz "Texto descriptografado: "

buffer: .space 32


.text
.globl main
main:

    ###### MENU PRINCIPAL ######

    
    li $v0,4
    la $a0, frase1
    syscall
    li $v0,11
    li $a0,10
    syscall

    
    li $v0,4
    la $a0, frase2
    syscall
    li $v0,11
    li $a0,10
    syscall

    # linha 3
    li $v0,4
    la $a0, frase3
    syscall
    li $v0,11
    li $a0,10
    syscall

    ###### MENU DE CIFRAS ######

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


    ########## LEITURA DAS OPCOES ##########

    # "Digite a opcao"
    li $v0,4
    la $a0, frase7
    syscall

    # opcao 1 = criptografar | 2 = descriptografar
    li $v0,5
    syscall
    move $t0, $v0        # guarda 1 ou 2


    # ler cifra escolhida
    li $v0,4
    la $a0, frase7
    syscall

    li $v0,5
    syscall
    move $t1, $v0        # 1 = cesar, 2 = rot13, 3 = xor



    # Se cifra == 1 (César)
    li $t2, 1
    beq $t1, $t2, cesar_switch

    # Se cifra ==2 ( ROT13)
    li $t2, 2
    beq $t1, $t2, rot13_switch

    j end



# Escolhe se vai criptografar ou descripto


cesar_switch:
    li $t3, 1
    beq $t0, $t3, cesar_cripto     # opção 1 → criptografar

    li $t3, 2
    beq $t0, $t3, cesar_descripto  # opção 2 → descriptografar

    j end



  


cesar_cripto:

   
    li $v0,4
    la $a0, msgTexto
    syscall

 
    li $v0,8
    la $a0, buffer
    li $a1, 32
    syscall

    # chave = 3 (César)
    li $t3, 3

    la $t4, buffer

cesar_loop:
    lb $t5, 0($t4)

    beqz $t5, cesar_fim

    add $t5, $t5, $t3      # criptografar = somar
    sb $t5, 0($t4)

    addi $t4, $t4, 1
    j cesar_loop


cesar_fim:
    li $v0,4
    la $a0, msgResultado
    syscall

    li $v0,4
    la $a0, buffer
    syscall

    j end


#   ROTINA: CIFRA DE CÉSAR (DESCRIPT) 


cesar_descripto:

    # mensagem
    li $v0,4
    la $a0, msgTextoD
    syscall

    # ler string
    li $v0,8
    la $a0, buffer
    li $a1, 32
    syscall

    # chave = 3
    li $t3, 3

    la $t4, buffer

cesar_loop_d:
    lb $t5, 0($t4)

    beqz $t5, cesar_fim_d

    sub $t5, $t5, $t3      # descriptografar = subtrair
    sb $t5, 0($t4)

    addi $t4, $t4, 1
    j cesar_loop_d


cesar_fim_d:
    li $v0,4
    la $a0, msgResultadoD
    syscall

    li $v0,4
    la $a0, buffer
    syscall

    j end
 #   CIFRA ROT13
rot13_switch:

    # Verifica se escolheu cripto
    li $t3, 1
    beq $t0, $t3, rot13_exec

    # Ou descripto (ROT13 é igual)
    li $t3, 2
    beq $t0, $t3, rot13_exec

    j end


rot13_exec:

    # Lê o texto do usuário
    li $v0,4
    la $a0, msgTexto
    syscall

    li $v0,8
    la $a0, buffer
    li $a1, 32
    syscall

    la $t0, buffer     # Ponteiro para o texto

rot13_loop:
    lb $t1,0($t0)      # Pega caractere atual
    beqz $t1, rot13_fim

    addi $t1,$t1,13    # ROT13 = somar 13
    sb $t1,0($t0)

    addi $t0,$t0,1     # Avança para o próximo char
    j rot13_loop


rot13_fim:

    # Exibe resultado
    li $v0,4
    la $a0, msgResultado
    syscall

    li $v0,4
    la $a0, buffer
    syscall

    j end


#           FIM DO PROGRAMA           


end:
    li $v0, 10
    syscall
