# Splunk


## Prereq

 What is machine data:  Data that is generated from almost all devices. This can be structured or non-structured data. Using a indexed log database and being able to parse the data for events that corrolate can take hours off investigations. Adds structure to non-structured data.
 
 Machine data is typically 90%  of data passed through networks. 
 
 
 ## What is splunk?
 
 Index data: Collects data from almost any source. As data enters, inspectors look at data to determine how it should be processed. When a match is found, it is labled with a source type. Workers use that source type to break the data to single events, and timestamps are analyzed and normalized to a consitent format. Then events are stored in splunk index.
 
 Search & investigate: Entering queries you can find events that contain values across various data sources. 
 
 Add knowledge: Can add these to your data. These allow you to affect how your data is interpreted, classification, enrichment, normalize and save reports.
 
 Monitor & alert: Can crate alerts to monitor logs for events/conditions.
 
 Report & analyze: Create visualizations and dashboards
 
 
 ## Main processing components
 
  - Indexer: Process incoming machine data and store this in the indexer. It is store in directories for specific time frames. So when data is searched it will only have to open directories related to that timeframe. Index are dir where the data will be stored.
  
  - Search Head: Allows you to use the splunk search language to search the indexed data. The queries are sent to the indexers to perform the search. Then the search header consolidates and enriches the results then returned to the user.
  
  - Forwarder: Typically resides on the data origin as an agent to forward data to the indexer. 
  
  Single instance of splunk handles input, parsing, indexing and searching of data.
  
  When scaling you will need to split/multiply this functionality across multiple systems, and clustering.
  
  
  ## Commands
  
  Installed under /opt/splunk
  
  commands under /opt/splunk/bin 
  
    ./splunk <start | stop | restart>
  
  
 Apps: Pre-config environments that sit on top of the splunk instance. Extend prebuild functions.
    Apps are defined by a user with an admin role.
    Roles: Determines what a user is able to see, do and interact with.
      3 main roles in splunk.
      
       - Admin: Can install and create apps knowledge objects for all users
       
       - Power: Can create and share knowledge objects for users of an app and do realtime searches.
       
       - User: Will only see their own knowledg eobjects and those shared with them.
  
   - 2 Preinstalled apps: Home and Search & report.
  
  
## Types of input

 Adding data is done by the admin.
  
  
  the "Add data" button on the dashboard.
  
    - Preconfigured plugins for services and OS
   
    - Upload local files to splunk
    
       - Only indexed once
    
        - Source types to catigorized types of data being indexed.
        - You can choose to save the source type to a specific app or system wide.

        - Input: hostname should be the data source system

        - You can store data in the main index or seperate indexes. 
           Seperate indexed make searches quicker, seperate data retention, and seperate roles.

    - Monitor lets us monitor files/dir, HTTP events, TCP/UDP and scripts. (there is more for windows specifically)
      
      - Can continuesly monitor
      
      - Source types to catigorized types of data being indexed.
        - You can choose to save the source type to a specific app or system wide.

        - Input: hostname should be the data source system

        - You can store data in the main index or seperate indexes. 
           Seperate indexed make searches quicker, seperate data retention, and seperate roles.
    

  
    - Forward lets us recieve dat afrom external forwarders.
  
 
 ## searching and reporting 
 
 The splunk UI has 7 main components:
 
  Top to bottom: 
    
     - Splunk bar: lets you switch apps, edit account, account, messages, settings, etc

     - App bar that lets you navigate the application. 

     - Search bar: run searches
     
        - Commands that create statistics and visualizations are called transforming commands.
        - Search jobs remain active for 10 min after its run, after that it will have to be re-run to return results. 
        - Shared search job will remain active for 7 days.

     - Time range picker
     
     - How to search panel
     
     - What to search: gives summary of data in the index. Data summary button gives more detais such as host, source and source types.



## Searching notes:

 searching two or more strings with no boolean, then AND is applied. 


 Boolean operation order of evaluation: 
 
   1. NOT
   
   2. OR
   
   3. AND

  () can be used to control this. 
  
   Example where OR will be evaluated first:
   
      Failed AND (Login OR Password)
      
   "" for exact phrases
   
   \ for escaping special characters.
      
   When looking for multiple values in the same field, you can use IN instead of OR.
    
    (status=500 OR status=501 OR status=502) 
    
    status IN ("500", "501", "502")

## Fields 

   Are the indexed parts of each piece of the log. When logs are searched there will be selected fields and interesting fields on the sidebar.
   
   Selected are the most imported
   
   Interesting are the fields that show up in at least 20% of the events.
     a = string
     # = number
   
There is an "All fields" button at the top and an "x more fields" button at the bottom of the fields list.

## Searching fields 


search for logs that contain fields(cannot use wild cards):  sourcetype=<field name>
 
 Field operatios:   
 
   Numerical or string values:
   
      = 
     !=
     
   Numerical values:
   
     >    #Greater than
     >=   #Greater than or equal to
     <    #less than
     <=   #less than or equal to
 
 
search values inside fields:  <field name>=<value>

  
  Note: Difference between operators and boolean 
  
   Example: 
   
   status!=200 #returns all logs with status field that is not 200
   
   NOT status=200  #returns all logs where the field status does not have 200(including logs that does not have the status field).
       
       
 You can search multiple indexes at once:
 
    index=securty AND index=webserver
    
 Time:
 
   @ used to round down to nearest unit
   
     -30m@h  is the last 30 min rounded down to the nearest hour
     
   Can also use the searchbar to specify time
   
      sourcetype=example earliest=-2h latest=-1h
       
## Best practises

 Specific timeframe
 
 default fields that are the most powerful after time:
 
 
 
   - index
   
   - source
   
   - host
   
   - sourcetype
 
 
Inclusion is usually better than exclusion 


       
       
       
       
       
