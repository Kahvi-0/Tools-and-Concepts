Download: https://sourceforge.net/projects/nasmx/

Add NASM to the environment PATH: 

Search: Environment Variables ->  Environment Variables -> Edit Path -> New -> Full path to /NASM/bin



**Assemble .asm file to object file**

    nasm -f win32 <file.asm> -o <file.obj>
    
     -f output file format
         win32   Microsoft object file format for 32-bit OS


**Linking object files to DLL files to create an executable**

     GoLink.exe  /entry _main <file.obj> <kernel32.dll> <user32.dll>
     
     /entry telling the linker that the entry pointo for the program is _main. 








