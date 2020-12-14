.data 

msg_programa: .asciiz "\nRede Neural Perceptron para somar numeros iguais\n"
msg_w1: .asciiz "\nAtualizando W1:\n"
msg_w2: .asciiz "\nAtualizando W2:\n"
msg_entrada: .asciiz "\nValor entrada:\n"
msg_previsto: .asciiz "\nProduto Previsto:\n"
msg_achado: .asciiz "\nProduto Achado:\n"
msg_erro: .asciiz "\nTaxa de erro:\n"
msg_l: .asciiz "\n\n"

w1 : .float 0.0
w2 : .float 0.8
aprendizado : .float 0.05
entrada : .word 1
.text
main: # sss
l.s $f0,w1 
l.s $f1,w2 
l.s $f2,aprendizado 
lw $s3,entrada
add $s4,$s3,$s3 #Numero Previsto

li $v0, 4
la $a0, msg_programa
syscall 
Repeticao: slti $s8,$s3,6
beq $s8,$zero,final

mtc1 $s3,$f3
cvt.s.w $f3,$f3
mtc1 $s4,$f4
cvt.s.w $f4,$f4
  
li $v0, 4
la $a0, msg_w1
syscall 
li $v0, 2
mov.s $f12, $f0
syscall 
 
li $v0, 4
la $a0, msg_w2
syscall 
li $v0, 2
mov.s $f12, $f1
syscall 
 

li $v0, 2
mov.s $f12, $f2
syscall 

li $v0, 4
la $a0, msg_entrada
syscall
 li $v0, 2
mov.s $f12, $f3
syscall 

li $v0, 4
la $a0, msg_previsto
syscall  

li $v0, 1
move $a0, $s4
syscall 

mul.s $f5,$f0,$f3 # soma w1
mul.s $f6,$f1,$f3 # soma w2
add.s $f6,$f5,$f6 # Somando w1 e w2
li $v0, 4
la $a0, msg_achado
syscall 
 

li $v0, 2
mov.s $f12, $f6
syscall 

sub.s $f7,$f4,$f6 #Achando o erro
mov.s $f8,$f7 
mul.s $f7,$f7,$f2 #Erro x Taxa
mul.s $f7,$f7,$f3 #Erro x Entrada 

 
add.s $f0,$f0,$f7 #w1 +Erro x Taxa x Entrada
add.s $f1,$f1,$f7 #w2 +Erro x Taxa x Entrada
 
li $v0, 4
la $a0, msg_erro
syscall 

li $v0, 2
mov.s $f12, $f8
syscall 
li $v0, 4
la $a0, msg_l
syscall


addi $s3,$s3,1
add $s4,$s3,$s3

j Repeticao
final: jr $ra
