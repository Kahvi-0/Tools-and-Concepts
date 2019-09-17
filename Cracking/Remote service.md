<details>
 <summary>Creating wordlists</summary>
 <br>
   Crunch
      
       crunch <smallest len> <largest len> <options> > outputfile
 
</details>

Location of wordlists on kali /usr/share/wordlists
Basic router passwords: routerpasswords.com

<details>
 <summary>Hydra</summary>
 <br>
  Help: https://tools.kali.org/password-attacks/hydra
  
  Basic
  
    hydra 
         -l (login name) or -L (wordlist of login names)
         -p (password) or -P (wordlist of passwords) 
         <IP> <service>
 
   
</details>


<details>
 <summary>Metasploit</summary>
 <br>
  
    SSH: use auxiliary/scanner/ssh/ssh_login
    SNMP: use auxiliary/scanner/snmp/snmp_login
    
    SNMP: 
</details>

<details>
 <summary>ncrack</summary>
 <br>
 
</details>

<details>
 <summary>medusa</summary>
 <br>
 Help: https://en.kali.tools/?p=200
 
   Basic
    
     medusa 
        -h <host>
        -u <user> -U <wordlist for user>
        -p <password> -P <wordlist for passwords>
        -M <module to execute>
 
</details>


<details>
 <summary>NMAP</summary>
 <br>
  
    SNMP: nmap -sU -p <port> -n --script snmp-brute <host> --script-args snmp-brute.communitiesdb=<wordlist>
</details>

















<details>
 <summary> </summary>
 <br>
 
</details>
