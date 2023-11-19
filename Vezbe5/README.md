# MiniC Semantic Checks

This project focuses on extending the MiniC language grammar with semantic checks for new data types and statements.

## Task 1: Void Type

Extended grammar with a new data type, void, which can only be used as the return type of a function. Semantic checks include detecting improper use of the void type.

## Task 2: Return Statement

Added a return statement with the form "return ;". Semantic checks include detecting errors and warnings related to the return type of a function.

Semantic checks matrix:

|       | void | int/unsigned |
|-------|------|--------------|
| return exp ; | error | OK |
| return ;     | OK   | warning |
| No return    | OK   | warning |

## Task 3: For Statement

Extended grammar with a for statement that includes the declaration of an iterator, a relation, and a statement. Semantic checks include type checks and proper iterator management.

Example of a valid for statement:

int x;
x = 0;
for (int i = 0; i < 8; i++)
  x = x + i; 

## Task 4: Branch Statement
Extended grammar with a branch statement that has conditions and four statements. Semantic checks include type checks and the correct order of constants.

Example:

branch (a; 1, 3, 5)
  first a = a + 1;
  second a = a + 3;
  third a = a + 5;
  otherwise a = a - 3;


## Task 5: Switch Statement
Extended grammar with a simplified switch statement that includes cases and an optional default block. Semantic checks include type checks, uniqueness of constants, and proper usage of break statements.

Example:

switch (state) {
  case 1: x = 1; break;
  case 2: { x = 5; } break;
  default: x = 10;
}
