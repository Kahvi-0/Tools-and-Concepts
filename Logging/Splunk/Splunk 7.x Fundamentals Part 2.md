# Splunk 7.x Fundamentals Part 2


useful commands: 

dedup - remove duplicate field values

top - shows the most common (default 10 results)

rare - Shows the least common ( default 10 results)

stats - to calc stats between 2 or more or more fields when you do not need the data to be time based. 


Fields, boolean, tags, and specific value are case sensitive

Search terms, values, clauses, and funtions are not case sensitive


Math functions:

  count 
  
  sum(<field>)

Buckets: 

Dirs that contain raw data and indexing data. They have a max size and timespan. 
3 types of configurable buckets. The purpose of this is to make searches more efficient when searching as buckets out of the timeframe will not be opened:

Hot: Placed here as events are indexed. Only wirttable bucket. Once buckets max size, time span is reached or indexer is restarted it is rolled over to a warm bucket. 

warm: The bucket is then closed, renamed and changed to read only. Naming is db_<youngest eventid>_<oldest eventid>

Cold: Warm buckets are rolled into cold buckets when max size or time span is reached. Typically stored on a different device.


Wild card note: Do not put * at the beginning of search, in the middle of a word, or to match puncuation.


## Search modes

Fast mode: Only returns essential data. Only fields required for the search are extracted. Events and patterns are available. As with non tranforming commands, stats and visualizations are not available. However if we search with a transorming command, events and patterns are not but the stats and visualization are. 

Verbose mode: You get events and patterns. All fields are extracted. Running a transform command will let us see events, patterns, stats, and vis.

Smart: Combo of smart and fast to try and give the best results. Non-transform returns just events and patterns with all fields and transforms return just stats and vis 


## Best practise: 

After time, index, source, host, and sourcetype are the most powerful and should be added to the search as early as possible. 
These are extracted at index time so they are not extracted at search.

use "| fields" command to extract  only the fields needed.

## Job inspector

Found after a search is ran under the serach bar. This will give you the stats on how the results were found.


## Visualization commands

Typically requires data from a table with at least two coloums. 
 
  Reporting commands help map multiple datapoints to a visualiztion. 

**chart** command. Calc stats with an arbitrary field as the X axis that is not time. Takes two clauses, over and by. over = field of X axis. Only one field can follow the by clause.
 Any stats function can be applied to the chart command. Chart by default is limited to 10 columns.
 If a null value is in the chart, try to remove the null items before the chart operator. OTHER column can be removed with "useother=f".
 limit=x can limit how many plots are shown.
 
    chart
       <stats command>
           over <field>
               by <field>  (will split the X axis field by each value of this field)
 
    | chart count by status
    | chart count over status by host


**Timechart** command performs stats aggregations over time. Time is always X axis
  Similar to chart. By default the clusters that you hover over to get total times on timecharts are for 24h, to change this use "span=x<m|h|d>".

    | timechart
        <stats cmd>
           by
     
    | timechart count by <field> 


**Timewrap** command.

  Used to split up a chart that spans a period of time into equal parts to compare with other parts. i.e splitting 27 days by 7 day time frames and lining them up

    | timewrap x<m|h|d>


## Advanced visualizations


**Iplocation**

 Used to obtain location data from IP addresses. Note that not all will result in a location.
 The lat and lon fields can be used with commands like geostats.

    | iplocation <field>


**geostats**

Aggregates geographical data for use on a map visualization. Uses the same functions as the stats command.


    | geostats latfield=<latitude> longfield=<longitude> 
            count
                by <field>   (only 1 by)
                    globallimit=X    (limit the number of results from by)



**Choropleth map**


Uses shading the show data over locations. KMZ files to define countires and boundaries.

    | geom <kmz file>  featureField=<that map to location name name>


**Single value visaulizations**

 
single value displays a single intiger

gauge displays  


**trendline**

computes moving avg of field values. 
Requires 3 arguments:

    | trendline <trendtype><timeperiod>(<field>)
          <trendtype>   (sma, ema or wma)
          <time period>   (between 2-10000) Avg data point with number given with the timeframe of the serarch.


**Addtotals**

 Computes the sum of all numeric fields for each event.


     | addtotals 
             col=true  (creates a new row witha total of each column)
                      label=   (labes the row)
                           labelfield=<field>   (field to show the label in)
                                      

## Filtering and formatting

**Eval**

Manipulate and calculate field values. Arithmetic, concatenation, and boolean operators supported. Results can be written to new field or replace an existing field. Newly created field values are case sensitive. Takes fields with numeric values.  Eval created new field values, the underlying data in the index does not change.

    | eval <field> <calculation>
    
    | eval <new feild name>=<calculation> 
    
    sourcetype="access_combined" |  timechart span=1d sum(bytes) as bytes | eval megabytes=round(bytes/(1024*1024),2)


 Functions: 
 
   - tostring  (converts numerical values to strings)
   
   - if(<boolean>,<if ture>,<if false>) 
      
       i.e eval <new field>=if(field < 40,"true","false")
                        
   - case  (allows you to take multiple boolean expressions and return the corrosponding argument that is true.
         Of by the end something does not equal to any youcan add a true() function to categorize what is left over.
   
         | eval <new field>=case(stat)

         | eval httpstatus=case(status>=200 AND status<300,"success",status>=300 AND status<400,"Redirect",status>=400 AND status<500,"Client Error",status>=500,"Server Error", true(), "something wrid")


**eval with stats**

     | stats count(eval(status<300)) as "success", count(eval(status<400)) as "Error"


**fieldformat**

 Format values without changing characteristics of underlying values. Same functions as the eval command.



**search**

Allows you to use search terms further down the pipeline.


**Where**

Uses same expression syntax as eval and many of the same functions. Filters events that evaluate to true.


**eval/where tips**

* cannot be used as a wildcard, use  like "United St%"   (using  % (matches multiple) or _ (matches 1 character) )


**fillnull**

 replace null value (default blank)
 
    | fillnull value="nothing to see here"


## transaction

Any group of related events that span time.


**transaction command**

 Combines related events into a single event. Limit of 1000 events into a single. Creates two new fields: duration and eventcount.

     | transaction <field>


  Definitions
   
    - maxspan    allows you to set max total time between earliest and latest event
    
    - maxpause    allowed max total time between events
    
    - startswith  Allows forming transactions starting with specified: terms, field values or evaluations.
    
    - endswith    Allows forming transactions ending with specified: terms, field values or evaluations.


## Knowlege objects

Tools that help you discover and analyze data. This inclues data interpretation, classification, enrichment, normalization, and search time mapping. Can be created by one user and shared with other users.

- Naming convention: Help you know what each knowledge object does. Recommended: Group-Type-Platform-Category-Time-Description. 

**Permissions** 3 pre-defined ways Knowlege objects can be displayed to users:

 - Private: Default and only viewable by the user that created it.
 
 - Specific app: Power User and Admins are allowed to create KO that can be shared with all users of an app. May grant other roles with read and write permissions for that KO.
 
 - All apps: Admin can make KO that is available for all apps.

**Managing**

  found under  Settings -> Knowledge. Each of these will be a management page for KO related to that section. 



## CIM (common information model)

 Able to take fields from two different indexes and normalize them into one field. Uses a schema that defines standard fields between sources to create common base references.



## Field extractions

Can extract parts of events as new fields. There are two methods on how to do this: 

- Regular expression: work well with unstructured data and events you want t oextract fields from

- Delimiters: Used when events contain fields separated by a character.


## Field Aliases

Way to normalize data over multiple sources. One or more aliases to an extracted field. Example: two sourcetypes, each having their own type of username field, user and UID. The extracted fields can however still be refernced after.


    Settings -> fields -> Field aliases + add new.

    Dest app: ususally search

    Name: Same of saved alias

    Apply to <src type> named <name of source>

    Field aliases <extracted field> = <alias>


**Calculated fileds** must be based on an extracted field. Output fileds from a lookup table or fields generated from within a search string are not supported.

    Settings -> calculated fields -> Field aliases + add new.

    Dest app: ususally search
    
    Apply to <src type> named <name of source>

    Name: Same of saved alias   # used as the field name at search

    Eval expression: <eval expression>
