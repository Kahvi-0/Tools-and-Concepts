## Finding exfiltration vectors

[EgressCheck](https://github.com/stufus/egresscheck-framework)
  
  Create a tcpdump on the attacking machine and a python script for the compromised machine. Running the python script will send packets on each egress port to the attacking machine. The Packets seen by the the attacking machine with certain dst port shows what egress ports are open on the firwall(s) between the comprosmised machine and your attacking machine.
    
    
    
# Exfiltration tools

 ## Via DNS
 
   [Packet whisper](https://github.com/TryCatchHCF/PacketWhisper)
     
   Run packet whisper on a compromised machine to send files to your attacking machine via DNS. There are levels of top line tactics for exfiltrating that can bypass SIEM and DNS filters. 
