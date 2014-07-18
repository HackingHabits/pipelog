pipelog
======

Allow tracking your analysis pipeline and background processes. Most of us use logfiles which are separated based on services. Apache, Nginx, each processing worker pipeline, database etc. It gets harder to see failures per business object. 
Pipelog is a new paradigm to store numerous small log files per business object. E.g., if you are tracking a pdf file extraction process, create a log file for this pdf file. Log all processes across various systems on this pdf file into this log file. 

Log file is a document in elastic search. pipelog server offers a `websocket` enabled system to index into elastic search.
In the example below, we have stored two logs stored in a single logfile (elastic serach document) with key `"com.pdf.1"`. We also note that two different analysis have produced two `logs` into this logfile.  


    "_source":{  
       "key":"com.pdf.1",
       "tags":null,
       "timestamp":"2014-07-17 19:42:05",
       "logs":[  
          {  
             "pretty_name":"Analysis 1 for pdf id 15",
             "log_key":"ANALYSIS-1-15",
             "success":false,
             "notes":"/ this is a big ass time traceback/ that needs to be store for analysis",
             "timestamp":"2014-07-17 22:03:52"
          },
          {  
             "pretty_name":"Analysis 2 for pdf id 15",
             "log_key":"ANALYSIS-2-15",
             "success":true,
             "notes": null,
             "timestamp":"2014-07-17 22:04:12"
          }
       ]
    


