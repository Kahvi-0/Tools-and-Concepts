# WebEnum

This tool for enumerating websites using the following techniques:

- Directory brute forcing 
    - You can set the strength of the brute force list
    - Uses custom list of file extensions
    - Follows redirects
    
- Detect CMS and run according scans 

- Sorting the results by response code

- Screenshoting every page

- Running vulnerability scans against the site
  
    - **To add CMS and tech discovery later to tie into tech specific vuln scanners such as wpscan**
 
 All information is added to an overview HTML page that displays all discovered information.


## Usage:

    webEnum.sh <http://target> <port> <directory bust level>
    
    
    
**Using this script with BURP**

Proxy -> Options -> Proxy Listeners -> Add
Binding: port: 8081  Loopback only
Request handling: Redirect to host: <target IP> <target port>
  
  Now run the script pointing to 127.0.0.1 8081.
