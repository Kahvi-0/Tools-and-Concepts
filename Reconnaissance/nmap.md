# NMAP


Syntax:

      nmap <scan type> <other options> <target>

### NMAP scan phases

![nmapscanphases](https://user-images.githubusercontent.com/46513413/70617693-317aa680-1bdf-11ea-9498-ae16f11faced.png)



#OS detection:

 -O

nmap default scan type is sS (stealth)

  sU UDP
  
  sT TCP connect
  
  sA ACK scan


Nmap defaults to the top 1000 ports

 -p- all ports
 
 # Scripts
 
 -sC 
     Performs a script scan using the default set of scripts. It is equivalent to --script=default. Some of the scripts in this category are considered intrusive and should not be run against a target network without permission. 
--script filename|category|directory|expression|all[,...] .
    Runs a script scan using the comma-separated list of filenames, script categories, and directories. Each element in the list may also be a Boolean expression describing a more complex set of scripts. Each element is interpreted first as an expression, then as a category, and finally as a file or directory name. The special argument all makes every script in Nmap's script database eligible to run. The all argument should be used with caution as NSE may contain dangerous scripts including exploits, brute force authentication crackers, and denial of service attacks.

    File and directory names may be relative or absolute. Absolute names are used directly. Relative paths are looked for in the following places until found: 
 
 # Vulneabiltiy scanning
 
 Example:
 
      nmap -sV -Pn --script nmap-vulners,vulscan --script-args vulscandb=<file>.csv <IP>

 Install the scripts

   vulscan
 
       cd /usr/share/nmap/scripts/
       git clone https://github.com/scipag/vulscan.git
          
   Update vulscan 
    
     cd vulscan/utilities/updater/
     ./updateFiles.sh
  
   nmapvulners
 
      cd /usr/share/nmap/scripts/
      git clone https://github.com/vulnersCom/nmap-vulners.git    


  Finding vulscandb files to use:

       ls /usr/share/nmap/scripts/vulscan/

 
 
 More: https://linux.die.net/man/1/nmap

