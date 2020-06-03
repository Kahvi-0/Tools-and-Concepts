## Assembler

Assembler: program that translates the Assembly Language to the machine code.  When a source code file is assembled, the resulting file is called an object file (binary rep of the program).


Assemblers: 

 MASM (Microsfot Macro Assembler): x86 uses Intel syntax for MS-DOS and Windows
 
 GAS(GNU Assembler): used by GNU project, default back-end of GCC
 
 NASM(Netwide Assembler): x86 arch used to write 16-bit, 32-bit (IA-32) and 64-bit (x86-64) programes, one of the most popular assemblers for Linux  
 
 FASM (Flat Assembler FASM): x86, supports Intel-style assembly language on the IA-32 and x86-64
 
 -----------------
 
 
 Assembly instructions and machine code have a 1:1 corrospondence and translation process may be simnple, the assembler does some further operations such as assigning mem location to variables and instructions and resolving symbolic names. 
 
 Once the assembler creates the object file, a linker is needed to creeate the actual executable file. A linker takes one or more object files and combines them to create the executable. 
 
Example: two .dll files which are required to create the windows executable that access certain libraries. 

Process from Assembly code to executable. 
 
<img width="1242" alt="Capture" src="https://user-images.githubusercontent.com/46513413/83590551-06d13100-a524-11ea-96bd-820a896ab556.PNG">

## Compiler
 
Similar to the assembler. Converts high-level source code (like C) into low-level code or directly into an object file, then the previous process will be executed on the file, creating an executable file. 


 
 
 
 
