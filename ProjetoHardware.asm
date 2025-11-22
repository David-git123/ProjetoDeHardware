.data
frase1: .asciiz "UTILITARIO DE CRIPTOGRAFIA"
frase2: .asciiz "1 - CRIPTOGRAFAR"
frase3: .asciiz "2 - DESCRIPTOGRAFAR"
frase4: .asciiz "1 - CIFRA DE CESAR"
frase5: .asciiz "2 - CIFRA DE ROT13"
frase6: .asciiz "3 - CIFRA XOR"
frase7: .asciiz "Digite a opcao: "

msgTexto: .asciiz "Digite o texto para criptografar (max 31 chars): "
msgResultado: .asciiz "Texto criptografado: "

buffer: .space 32


.text
.globl main
main:

    ###### MENU PRINCIPAL ######

    # Linha 1
    li $v0,4
    la $a0, frase1
    syscall
    li $v0,11
    li $a0,10
    syscall

    # linha 2
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


    ########## DESVIO PARA A CIFRA ##########

    li $t2,1
    beq $t1, $t2, cesar_cripto   # se cifra = 1 → César



    j end



# ROTINA: CIFRA DE CÉSAR (CRIPT)  


cesar_cripto:

    # exibe pedido de texto
    li $v0,4
    la $a0, msgTexto
    syscall

    # lê string
    li $v0,8
    la $a0, buffer
    li $a1, 32
    syscall

    # chave = 3 (César)
    li $t3, 3


    la $t4, buffer

cesar_loop:
    lb $t5, 0($t4)         # caractere atual

    beqz $t5, cesar_fim    

    add $t5, $t5, $t3      # soma chave
    sb $t5, 0($t4)         # salva caractere

    addi $t4, $t4, 1       # avança
    j cesar_loop


cesar_fim:
    # mostra texto criptografado
    li $v0,4
    la $a0, msgResultado
    syscall

    li $v0,4
    la $a0, buffer
    syscall

    j end



#      FIM DO PROGRAMA           


end:
    li $v0, 10
    syscall
