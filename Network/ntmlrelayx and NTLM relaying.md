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


# NTLM relay background from [here](https://byt3bl33d3r.github.io/practical-guide-to-ntlm-relaying-in-2017-aka-getting-a-foothold-in-under-5-minutes.html)

## NTLM vs. NTLMv1/v2 vs. Net-NTLMv1/v2

  **NTLMv1/v2 is a shorthand for Net-NTLMv1/v2 and hence are the same thing.**

  NTLM hashes are stored in the Security Account Manager (SAM) database and in Domain Controller's NTDS.dit database. Can be also obtained using Mimikatz (Windows >= 8.1 you can get NTLM hashes from memory). Some tools just give you the NT hash (e.g. Mimikatz) and that's fine: you can still Pass-The-Hash with just the NT hash.
  
  Net-NTLM hashes are used for network authentication (they are derived from a challenge/response algorithm and are based on the user's NT hash).
  
 From a pentesting perspective:

  - You CAN perform Pass-The-Hash attacks with NTLM hashes.
  
  - You CANNOT perform Pass-The-Hash attacks with Net-NTLM hashes.
 
  
 **You get Net-NTLMv1/v2 (a.k.a NTLMv1/v2) hashes when using tools like Responder or Inveigh. **
 
 ## Relaying 
 
 Since MS08-068 you cannot relay a Net-NTLM hash back to the same machine you got it from (reflected attack).
 
 You don't have to crack the hashes you get from Responder, you can directly relay them to other machines.
 
 Set up [Responder](https://github.com/Kahvi-0/Tools-and-Concepts/blob/master/Network/Responder.md) for relaying .
  
  
  
  
  
  
  
