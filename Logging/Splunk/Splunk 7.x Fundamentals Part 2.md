# Splunk 7.x Fundamentals Part 2


useful commands: 

dedup - remove duplicate field values

top - shows the most common (default 10 results)

rare - Shows the least common ( default 10 results)


Fields, boolean, tags, and specific value are case sensitive

Search terms, values, clauses, and funtions are not case sensitive


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














