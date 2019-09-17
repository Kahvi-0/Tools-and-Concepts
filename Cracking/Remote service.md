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



# POST cracking service

<details>
 <summary>SNMP</summary>
 <br>
 
 snmpwalk shows us values
 snmpset changes values
 set uses the same basic syntax as walk with its own added arguments.
          
    snmpwalk:
      -v<number>  version
      -c <community string>
      <host> 
      > outputfile
    
    set:
      iso.x.x.x.x.x.x s <new string>
      
      
 ##  SNMP audits: 
   
   onesityone
   
     -c (communty strings files)
     <host>
     
   snmpcheck 
      
     -c <community string> 
     <host>
     
   metasploit
   
     use auxiliary/scanner/snmp/enum
     use auxiliary/scanner/snmp/enumshares  Only used for devices where this is supported 
     use auxiliary/scanner/snmp/enumsusers  Only used for devices where this is supported 

    if it is RW
    
     use auxiliary/scanner/snmp/snmp_set
       need to use snmptranslate -On iso.x.x.x.x.x.x.x.x. to a value metasploit understands
 
   NMAP NSE scripts 
       
     nmap -sU -p 161 --script "<script>" --script-args="snmpcommunity=<string>" <host>
     
     snmp-interfaces
     snmp-netstat
     snmp-processes
     
     
     more can be found under /usr/share/nmap/scripts/
     
</details>












<details>
 <summary> </summary>
 <br>
 
</details>
