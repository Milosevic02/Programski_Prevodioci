# Mini C Compiler

This repository contains the implementation of a compiler for the Mini C language. Mini C is a minimal programming language that supports variable declarations, loops, conditional statements, functions, and many other fundamental language constructs. Throughout this project, we have added support for numerous new language features to enhance the capabilities of Mini C.

## Implemented Features

Through these language extensions, we have introduced the following constructs:

1. **Multiple Variable Declarations**: In Mini C, you can now declare multiple variables in a single declaration by separating them with commas.

2. **Select Statement**: We have introduced the `select` statement, which allows you to select multiple variables from specific tables and define conditions for the selection.

3. **Do-While Statement**: We added support for the `do-while` statement, enabling you to execute specific commands as long as a particular condition is met.

4. **Post-Increment Operator**: We have implemented the post-increment operator, which can only be applied to identifiers.

5. **BASIC-Style For Loop**: Support for a BASIC-style `for` loop has been added, allowing various iterations based on specified directions and step values.

6. **Functions with Multiple Parameters**: Through grammar extensions, we made it possible to define functions that accept multiple parameters.

These extensions make Mini C a more powerful language, enabling you to tackle a wide range of programming tasks.

## Using the Compiler

1. Clone the repository.
2. Open a terminal in the project directory.
3. Run the `make` command to compile the project.
4. The `make` command will output a `gcc` command. Copy and execute it.
5. Run the compiler using `./syntax < test.mc`, where you can replace `test.mc` with your Mini C program.
6. Feel free to modify the `test.mc` file to experiment with various examples and test cases.
