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

