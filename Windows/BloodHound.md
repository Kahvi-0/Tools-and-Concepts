# BloodHound

[Information](https://github.com/BloodHoundAD/BloodHound/wiki/Data-Collector)

<details>
<summary>Installation and setup</summary>
 <br> 
  
    apt install bloodhound
 
 Connecting to neo4j
 
    neo4j console
    
 In a web browser navigate to localhost:7474
 
 default creds are neo4j for user/pass
 
 Create a new password
 
 Close browser
</details>   

## Collecting info

 In new terminal type "bloodhound", login and you are now using Bloodhound.
 
 You will now need an ingester for the data. 
 
 [SharpHound.ps1](https://github.com/BloodHoundAD/BloodHound/blob/master/Ingestors/SharpHound.ps1)
 
 [Data Collector Info](https://github.com/BloodHoundAD/BloodHound/wiki/Data-Collector)
 

    . .\SharpHound.ps1
    
     Invoke-BloodHound -CollectionMethod All -Domain <domain> -ZipFileName <name>.zip
     
Transfer the .zip back to the attcking machine. 

In BloodHound click "Upload Data" on the right side.

Find the .zip file that was generated.

After all files have been uploaded 


## Using BloodHound

 There is a wealth of infomation that you can display here. 
 
 Most useful: 
 
 
