## Semantic Practice in miniC

Here you can find solutions and programs for this tasks.

### Task 1.1

**Task Description:** Extension of the grammar so that multiple variables can be declared in one declaration, separated by commas. Implementation of semantic checks:
1. A variable must not be previously declared.
2. Local identifiers must be unique.

### Task 1.2

**Task Description:** Extension of miniC expressions with the post-increment operator. Implementation of semantic check:
1. The post-increment operator can only be applied to variables and parameters (not, for example, to functions).

### Task 1.3

**Task Description:** Extension of miniC grammar with the do-while statement. The syntax of the do-while statement is:
```c
do
  <statement>
while (<id> <relop> <lit>);
```
Implementation of semantic checks:
1. `<id>` must be an existing variable or parameter.
2. `<id>` and `<lit>` must be of the same type.

### Task 1.4

**Task Description:** Extension of miniC grammar with multiple assignments:
```c
a = b = c = d = e + 5;
```
For each `=`, both sides of the equality must have the same type, and all identifiers must be defined.

---

*Note: This README is part of exercises for practicing semantics in the miniC language. For additional information and questions, feel free to reach out.*
