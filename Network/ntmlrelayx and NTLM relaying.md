# ntlmrelay

Used for relay attacks against local network services. 

Used in conjunction with [Responder](https://github.com/Kahvi-0/Tools-and-Concepts/blob/master/Network/Responder.md) or [mitm6](https://github.com/fox-it/mitm6/) 

 **Syntax**
 
    ntlmrelayx.py  <target> <domain>
    
    -t  single target. IP  or <service>://<IP>
    
        Services: smb, ldaps, mssql, and more
    
    -tf  file that contains a list of targets
    
    -wh   to give fate WPAD file if doing [IPv6 attacks](https://github.com/Kahvi-0/Vulnerabilities-and-Exploitations/blob/master/Network/IPv6%20attacks.md)
    
    -l <output directory>
    
     <smb version> -smb2support if needed
  
    -i  interactive shell
  
    -c execute a specific command
  
    -e  execute local file on server

 
  
 **You get Net-NTLMv1/v2 (a.k.a NTLMv1/v2) hashes when using tools like Responder or Inveigh. **
 
 ## Relaying 
 
 Since MS08-068 you cannot relay a Net-NTLM hash back to the same machine you got it from (reflected attack).
 
 You don't have to crack the hashes you get from Responder, you can directly relay them to other machines.
 
 Set up [Responder](https://github.com/Kahvi-0/Tools-and-Concepts/blob/master/Network/Responder.md) for relaying .
  
  
  
  
  
  
  
