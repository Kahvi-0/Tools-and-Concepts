F2 - set break point

F7 - step into (execute one instruction)

F8 - step around instruction


Main CPU ( CTL + C) panel: 

Top left: disassembler panel:  Memory addr of instruction- machine code/OPCODE (hex value of instruction)- Assembly language - debugger comments

Top right: Register pane: Names of registers, their content, if a register points to an ASCII string, the value of the string

Bottom left: Memory Dump Panel - shows memory locations and relative contents in multiple formats (i.e hex, UNICODE, etc) 

Bottom right: Stack Panel:  Mem address of the stack - value on the stack at that address - explanation of the contents (if its an address or a UNICODE string, etc) - debugger comments
 
   - double clicking the memory allows us to see the relatice offset of each memory address.
   
   - right clicking a memory address and saying follow in dissasemble will show that instruction in the disassembled view. 

**Adding arguments to programs**

Before running the program

Debug -> Arguments

Now click the << at the top of the screen for the changes to take effect. 

**Find ascii text from code**

Right click dissasemble panel -> search for -> All refernce text strings

Double clicking on any string will bring you back to the disassembled section where the string is defined







