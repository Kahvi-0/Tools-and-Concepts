Manual updates
https://forums.hak5.org/topic/36363-guide-manually-updating-the-lan-turtle/

Connect via USB side: 

ssh root@172.16.84.1


Network config: 

  Config > Configure 3G Modem > Enable WAN fallback


Module locations:

    /etc/turtle/modules

 to start a module from here: ./<module> start
 
 USB IP: 
 
## Modules

### AutoSSH
  
  Modules: autossh and keymanager
  
  Require VM with SSH server. 
  
    
  On the server create user to run the connection
  
       adduser turtle
       
       sudo apt-get install openssh-server
       
       sudo ufw allow ssh
       sudo ufw enable
  
   On the turtle ise keymanager to generate keys and send the key to the server. (will be under /root/.ssh)
   
    Host: IP of SSH server
    Port: Listening port of SSH server
    User: user that was just created on server
    
    
   Set up autossh with the settings of the server.
   
   On the server connect to the LAN Turtle
   
    ssh root@localhost -p 2222
  
  ### sshfs
  
   edit the module and change both the -o options to nonempty and restart
   
 
  
 ### dnsmasq-spoof
 
  file: /etc/dnsmasq.hosts
  
 Continue working on
 
 ### quickcreds 
 
  Explination:
  
  Testing
  
 ### Responder
