# WebEnum

Tool for enumerating websites using the following techniques:

- Directory brute forcing 
    - Using [dirsearch](https://github.com/maurosoria/dirsearch)
    - Set the strength of the brute force list
    - Uses custom list of file extensions
    - Follows redirects
   
    
- Detect CMS and technologies
    - whatweb
    - CMSeeK

- Sorting the results by response code

- Screenshot responses
    - cutycapt

- Running vulnerability scans against the site
    - Nikto
  
  
 All information is added to an overview HTML page this lives in the root of the project directory that will be created.
 


## Usage:

    webEnum.sh <http://target> <port> <directory bust level>
    
Name the project (this will create a directory of that same name and all results will live there)
    
  **Bust levels**
  
  -1 small list 
  -2 small list + bigger list
  -3 small, big, and huge list
    
    
    
### Using this script with BURP

Proxy -> Options -> Proxy Listeners -> Add
Binding: port: 8081  Loopback only
Request handling: Redirect to host: <target IP> <target port>
  
  Now run the script pointing to 127.0.0.1 and port 8081.
  
  
## To Do 

- Have specific scans run for detected CMS
