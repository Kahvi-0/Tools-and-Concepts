## TSHARK is a command line based companion tool to wireshark. Where wireshark is great for microscopic analysis, Tshark is great for automation.

Tshark may be set up to only let root use pcap. For best practise, do not run this as root. to change:
  sudo dpkg-reconfigure wireshark-common
    -select yes
  - sudo usermod -a -G wireshark $USER
   newgrp wireshark

Interfaces: 
  Default only accept packets destined for it or broadcast or chose multicast.
  
  Promiscuous, tell interface to accept all packets. 
    sudo ifconfig $interface promisc
  
  Monitor mode: Basically promiscous mode for wireless (802.11)


If guidance is needed, similarly named parts are used in wireshark, i.e filters and stats.

### Examples

tshark -i en0 -w icmp.pcap


### OPTIONS

List supported interfaces: Tshark -D
 You can address the interfaces by name or number. The numbers are not fixed, so if they change, the represented int may change.
  default will use the first interface.

Check version: -v

Interfaces: -i $interface
                any
                                
Capture number of packets: -c #

statistics: -z 
      -z [stats],[filter]: 
      
                 io,phs  Create Protocol Hierarchy Statistics listing both number of packets and bytes. 
                 endpoints,...
                 conv,...
                 expert (packets that are malformed and/or do not follow standards)
                         If no filter is specified the statistics will be calculated for all packets.
                         Stats will be shown after displaying all packets, run with -q before -z to only show stats.
                         Filter can be just protocol, .ip, or any other filter. Display filter has no effect on stats as
                         its only filtering what to display to you as stdout.
                         Example:
                         tshark -r WiFi_traffic.pcap -q -z io,phs,'wlan.bssid == 6c:19:8f:5f:81:74'
                         tshark -r WiFi_traffic.pcap -q -z io,phs,ip

More quite stdout: -q

Preferences: -G $argument
             
    currentprefs: shows all current prefrences
    
Overwrite preference settings: -o
    
      [name]:[value]

Writeout: -w $filename

read file: -r $filename
             
             -c # to only display/capture a specific number of packet(s)
             -v will show all the details of the packet(s)
     
Export to a specific format: -T   (tshark -r xyz.pcap -T psml > xyz.psml)
                              
                              psml: high level view of packet in XML
                              pdml: very low level view of packet in XML
                              ek: elasticsearch

               #convert a pdml XML export to HTML 
               install xsltproc from repo
               wiresharks folder contains the file "pdml2html.xsl". Run:
               xlstproc /usr/share/wireshark/pdml2html.xsl  icmp.xml > icmp.html
       
Ring buffer options: -b  ( [Key:value])
      
      Keys - duration:value - interval:value - filesize:value - files:value
      Example -b filesize:1000 -b files:5
      https://www.embedded.com/electronics-blogs/embedded-round-table/4419407/The-ring-buffer
      Define a buffer and when the defined limit is reached, save the file and start a new one.

Filter note: Every capture/display filter you can use in wireshark can be used in tshark.

## Capture filters (https://www.wireshark.org/docs/man-pages/pcap-filter.html)
  Applies filters to low lever by the packet capture library to ensure that only the packets we are interested get captured.
  Contrasting with display filter. Uses BPF(Berkeley Packet Filter).
  
 syntax: tshark -i $interface -f "filter rule" -w tcp80.pcap

 Examples: tcp port X
 
 
### FILTERS 
 
 ## Display filters work on packets that have already been captured.
  https://www.wireshark.org/docs/wsug_html_chunked/ChWorkBuildDisplayFilterSection.html
  https://www.wireshark.org/docs/dfref
  Note: a good method to getting a proper filter is getting it from wireshark by selecting what you would like to filter > 
  right click > Apply as Filter > Selected. This will give you the filter. 
  
  Single pass display filter: -Y
  
  syntax: tshark -r file.pcap -Y "FILTER" 
 
  Example to only display SSID on beacon frames: tshark -r file.pcap -Y 'wlan.fc.type_subtype == 0x0008'  
  
  
##Extracting fields from packets

Syntax: -Tfields -e wlan.ssid

note: all selected elements in wireshark will display their fields on the lower lefthand corner of in brackets.

Example, extract ONLY the ssid field from ssid beacons captured:
  tshark -r file.pcap -Y 'wlan.fc.type_subtype == 0x0008' -Tfields -e wlan.ssid

Example, you want to not see empty SSIDs. So you need to make sure the field "Tag length" is greater than 0:

Example, show SSID with BSSID of AP. 
tshark -r file.pcap -Y 'wlan.fc.type_subtype == 0x0008' -Tfields -e wlan.ssid -e wlan.bssid

Adding header(to end of extracting options): -E header=y

channel number for wlans = wlan.ds.current_channel

All frame protocols: frame.protocols


## Piping into sort / uniq
 
 pipe your filter through tools like sort or uniq to help narrow down results. 
  
  tshark ..... | sort | uniq


## Decode-As  (-d)
 Lets you specify how a layer type should be parsed. For if something is running against standards.
  Use case example: VoIP could be encrypted and wireshark only shows these SIP-TLS RTP packets as UDP.
  Note: RTCP - Real time Control Protocol - if with lots of UDP packets, good indication of RTP traffic.
  
  show all decodes: -d .
  
  [what to decode],[decode as]  (udp.port==4000,rtp)
  
  

##Decrypt SSL traffic
  
  Find 
  
  -o "ssl.keys_list:[IP or quad 0 for all],[port],[protocol],[Key file]" 




##further scripting
 
  using pyshark
 



