.data
.data
frase1: .asciiz "UTILITÁRIO DE CRIPTOGRAFIA"
frase2: .asciiz "1- CRIPTOGRAFAR"
frase3: .asciiz "2- DESCRIPTOGRAFAR"
frase4: .asciiz "1- CIFRA DE CESAR"
frase5: .asciiz "2- CIFRA DE ROT13"
frase6: .asciiz "3- CIFRA DE XOR"
frase7: .asciiz "3- Digite a opção de escolha"
tamanhoInput: .word 32
cifra: .space 32

.text
.globl main
main:
li $v0,4
la $a0, frase1
syscall

#/n
li $v0,11
li $a0,10
syscall

li $v0,4
la $a0, frase2
syscall
#/n
li $v0,11
la $a0, 10
syscall

li $v0,4
la $a0, frase3
syscall

#/n
li $v0,11
la $a0, 10
syscall

li $v0,4
la $a0, frase4
syscall

#/n
li $v0,11
la $a0, 10
syscall

li $v0,4
la $a0, frase5
syscall

#/n
li $v0,11
la $a0, 10
syscall




	
