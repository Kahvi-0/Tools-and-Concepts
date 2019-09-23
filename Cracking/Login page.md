# Login pages

<details>
 <summary>Login pages with Burp</summary>
 <br>
  Set burp up as a proxy to your routers login page. 
  Capture a login request and in the "intercept" tab. Right click it and click "Send to intruder".
  Here you will be able to set up an attack against the login form. 
  After sending the request to intruder it will be in the "target" tab.
  In the "positions" tab is where you select the portion of the request that should be changed everytime.
  You may have to clear first as burp may auto grab positions.
  You will have to determine what type of auth the login page is using, this will change the following tabs.
  Once you found where the password/hash is in the requst, highlight the position and click "Add".
  In the payloads tab you will have payload set: 1 and payload type: Brute forcer.
  Payload options set characters and length.
  Payload processing, rules that change how to generated payload option is to be processed. Example: if you are brute forcing the password and you know the username is admin and the format of the hash is user:pass, you would want to add the prefic: admin:. this will add admin: to the begining of every generated password. And if that is supposed to be base64 encoded then add encode - base64 after. This all will be determined by the type of auth the login page is using.
 
 Types of auth: http://java.boot.by/wcd-guide/ch05s03.html
 
</details>

<details>
 <summary>HYDRA</summary>
 <br>
 More info:  https://linuxhint.com/crack-web-based-login-page-with-hydra-in-kali-linux/

  In a POST request:
  
    Example:
    
     hydra -l admin -P /usr/share/wordlists/rockyou.txt testasp.vulnweb.com http-post-form "/Login.asp?RetURL=%2FDefault%2Easp%3F:tfUName=^USER^&tfUPass=^PASS^:S=logout" -vV -f
     
    l <username> : is a word containing username account, use -L <FILE> to refer list of possible user name in a file.
    
    P <FILE> : is a file list of possible password, use -p <password> to literally use one word password instead of guess it.
  
    testapp.vunlwebapp.com : is a hostname or target
    
    http-post-form : is the service module we use
    “/Login.asp?RetURL=%2FDefault%2Easp%3F:tfUName=^USER^&tfUPass=^PASS^:S=logout” = the 3 parameters needed, the syntax is :
    {page URL}:{Request post body form parameters}:S={Find whatever in the page after succesfully logged in}
    
    v = Verbose mode
    V = show login:pass for each attempt
    f = Terminate program if pair login:password is found


</details>

