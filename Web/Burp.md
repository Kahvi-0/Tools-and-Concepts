

# Configuration

## Jython standalone

https://www.jython.org/download

## Extensions 

 SQLiPy
   - Requires command: python <path to SQLiPy> -s -H 127.0.0.1 -p 9090
 XSSValidator

 
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
 <summary>SQLiPy</summary>
 <br>
  
 - Level

This option requires an argument which specifies the level of tests to perform. There are five levels. The default value is 1 where limited number of tests (requests) are performed. Vice versa, level 5 will test verbosely for a much larger number of payloads and boundaries (as in pair of SQL payload prefix and suffix). The payloads used by sqlmap are specified in the textual file xml/payloads.xml. Following the instructions on top of the file, if sqlmap misses an injection, you should be able to add your own payload(s) to test for too!

Not only this option affects which payload sqlmap tries, but also which injection points are taken in exam: GET and POST parameters are always tested, HTTP Cookie header values are tested from level 2 and HTTP User-Agent/Referer headers' value is tested from level 3.

All in all, the harder it is to detect a SQL injection, the higher the --level must be set.

It is strongly recommended to higher this value before reporting to the mailing list that sqlmap is not able to detect a certain injection point.
 
  - Risk


This option requires an argument which specifies the risk of tests to perform. There are three risk values. The default value is 1 which is innocuous for the majority of SQL injection points. Risk value 2 adds to the default level the tests for heavy query time-based SQL injections and value 3 adds also OR-based SQL injection tests.

In some instances, like a SQL injection in an UPDATE statement, injecting an OR-based payload can lead to an update of all the entries of the table, which is certainly not what the attacker wants. For this reason and others this option has been introduced: the user has control over which payloads get tested, the user can arbitrarily choose to use also potentially dangerous ones. As per the previous option, the payloads used by sqlmap are specified in the textual file xml/payloads.xml and you are free to edit and add your owns.
</details>
