# Responder

Responder sets up servers that will listen to network traffic and will try to spoof responses for LLMNR, NBT-NS and DNS/MDNS to get information that would typically be intended for another destination such as usernames and password hashes.


**Syntax**

   responder -I <int> -rdwv
   
   -r 
   
   -d
   
   -w 
   
   -v Verbose



## Setting up for relaying 

Edit  "/usr/share/responder/Responder.conf" and turn off the services that apply to your relay attack. 

Below is an example for SMB relay.

      SMB = off   
      HTTP = off
