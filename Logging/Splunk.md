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
  
    - 





















