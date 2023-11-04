# Scanner and Regular Expressions

This repository contains exercises focused on building a scanner and regular expressions for text analysis. These tasks aim to recognize various tokens and patterns in the input text.

## Task 0 - Basic Token Recognition
In this task, you develop a C program to analyze an input text based on a simple grammar. The program identifies the following symbols:
- Words starting with an uppercase letter.
- Words starting with a lowercase letter.
- Periods.

For each recognized symbol, the program prints the token name (CWORD, WORD, or DOT) along with the corresponding string. If the program encounters an unexpected character not defined in the grammar, it reports "ERROR:" followed by the problematic character.

## Task 1 - Recognizing Numeric Values and Keywords
In this task, you create a scanner to recognize:
1. Integer numbers, including those with positive or negative signs.
2. Hexadecimal numbers starting with '0x' or '0X' followed by up to 4 hexadecimal digits.
3. Real numbers (with or without a sign) in decimal notation.
4. The "break" keyword in a case-insensitive manner.

## Task 2 - Removing Single-Line Comments
This task involves building a scanner to identify and remove single-line comments marked by '//'. The output should be the original code with the commented lines removed.

## Task 3 - Converting Fahrenheit to Celsius
In this task, you develop a scanner to convert Fahrenheit temperatures into Celsius. The rest of the text remains unchanged. The formula for temperature conversion is: (°F - 32) x 5/9 = °C.

## Task 4 - Handling C Block Comments
You solve the problem of recognizing C block comments, denoted by '/*' and '*/'. Special attention is given to nested comments, ensuring correct handling.

