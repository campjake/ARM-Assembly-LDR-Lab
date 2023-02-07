// Style sheet
// Programmer   : Jacob Campbell
// Lab #        : 4
// Purpose      : Loading and Storing
// Author       : Jacob Campbell
// Date         : Jan 30 2023

.global _start                          // provide starting address

        .data
                szPlus: .asciz  " + "   // + sign for output
                szEq:   .asciz  " = "   // = sign for output
                szX:    .asciz  "10"    // String containing 10
                szY:    .asciz  "15"    // String containing 15
                dbX:    .quad   0       // num
                dbY:    .quad   0       // num
                dbSum:  .quad   0       // sum of dbX + dbY
                szSum:  .skip   21      // buffer val
                chCr:   .byte   10      // Carriage return

        .text
        // Setup parameters to perform addition
        // then call Linux to do it
        _start: ldr X0, =szX    // load szX into X0
                bl ascint64     // fcn returns int to X0

                ldr X1, =dbX    // prep X1 to receive int
                str X0, [X1]    // *X1 = X0

                ldr X0, =szY    // load szY into XO
                bl ascint64     // fcn returns into to X0

                ldr X2, =dbY    // prep X2 to receive int
                str X0, [X2]    // *X2 = X0

                // Printing to Terminal
                ldr X0, =szX    // Load first num to reg
                bl putstring    // output num to terminal
                ldr X0, =szPlus // Load + sign to reg
                bl putstring    // output + sign to terminal
                ldr X0, =szY    // Load second num to reg
                bl putstring    // output num to terminal
                ldr X0, =szEq   // Load = sign to reg
                bl putstring    // Output = sign to terminal

                // Addition Operation
                ldr X0, =dbSum  // Prep dbSum to store sum
                ldr X1, =dbX    // Put dbX in X1
                ldr X1, [X1]    // Keep it there
                ldr X2, =dbY    // Put dbY in X2
                ldr X2, [X2]    // Keep it there
                add X0, X1, X2  // Store X0 =  X1 + X2
                ldr X1, =szSum  // fcn needs sz large enough to hold val
                bl int64asc     // X0 gets ascii now
                ldr X0, =szSum  // putstring needs string in X0
                bl putstring    // print sum to terminal

                ldr X0, =chCr   // load carriage return to reg
                bl putch        // fcn call carriage return

                // Setup the paramters to exit the program
                // and then call Linux to do it
                mov X0, #0      // Use 0 return code
                mov X8, #93     // Service command code 93
                svc 0