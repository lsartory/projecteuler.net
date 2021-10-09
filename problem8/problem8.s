.equ WIDTH, 13

.data
input:
    .ascii "73167176531330624919225119674426574742355349194934"
    .ascii "96983520312774506326239578318016984801869478851843"
    .ascii "85861560789112949495459501737958331952853208805511"
    .ascii "12540698747158523863050715693290963295227443043557"
    .ascii "66896648950445244523161731856403098711121722383113"
    .ascii "62229893423380308135336276614282806444486645238749"
    .ascii "30358907296290491560440772390713810515859307960866"
    .ascii "70172427121883998797908792274921901699720888093776"
    .ascii "65727333001053367881220235421809751254540594752243"
    .ascii "52584907711670556013604839586446706324415722155397"
    .ascii "53697817977846174064955149290862569321978468622482"
    .ascii "83972241375657056057490261407972968652414535100474"
    .ascii "82166370484403199890008895243450658541227588666881"
    .ascii "16427171479924442928230863465674813919123162824586"
    .ascii "17866458359124566529476545682848912883142607690042"
    .ascii "24219022671055626321111109370544217506941658960408"
    .ascii "07198403850962455444362981230987879927244284909188"
    .ascii "84580156166097919133875499200524063689912560717606"
    .ascii "05886116467109405077541002256983155200055935729725"
    .ascii "71636269561882670428252483600823257530420752963450"
input_end:
    input_len = input_end - input

.text
.globl _start
_start:
    # Set the initial values
    lea (input), %r12      # Use %r12 as a pointer to the data
    xor %r15, %r15         # Use %r15 as storage for the maximal product

outer_loop:
    xor %r13, %r13         # Reset the counter
    mov $1, %r14           # Set the multiplication accumulator to 1
inner_loop:
    lea (%r12, %r13), %rsi # Load the address of the next digit
    cmp $input_end, %rsi   # Check if the address is valid
    jge done               # If not, the process is complete
    xor %rdx, %rdx         # Reset the upper bits of the divisor
    xor %rax, %rax         # Reset the lower bits of the divisor
    mov (%rsi), %al        # Load the next digit
    sub $'0', %al          # Convert from ASCII to integer
    mul %r14               # Multiply
    mov %rax, %r14         # Save the result in %r14
    inc %r13               # Increment the counter
    cmp $WIDTH, %r13       # Check if the multiplication window is full
    jl inner_loop          # If not, continue
    cmp %r15, %rax         # If yes, check if the product is the largest
    jle inner_skip         # If not, do not store it
    mov %rax, %r15         # If yes, store it in %r15
inner_skip:
    inc %r12               # Increment the base pointer
    jmp outer_loop         # Loop again

done:
    # Print the result
    mov %r15, %rax
    call print_int
    call print_endl

    # Exit the program
    mov $0, %rdi
    mov $60, %rax # sys_exit
    syscall
.end
