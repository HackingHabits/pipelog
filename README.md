piping
======

Allow tracking your analysis pipeline and background processes. In a log of cases, one would like to 
understand where things are failing in a pipeline of background analysis. This project
provides a way to track a single object through multiple analysis and track failure, with traceback. 

Once can also use `piping` to just take notes from background jobs. e.g, you can start accumulating
string data for a key "my.wonderful.pipeline.for.item.1" and the values could be "failed with NoMethodError"
or "Completed successfully".

The final document will look like:

>   {
>     "my.wonderful.pipeline.for.item.1" : {
>        "events" : [
>                     "pipeline process 1": "success",
>                     "pipeline process 2": "success",
>                     "pipeline process 3": "failed"
>                    ]
>        
>      },
>      
>     "my.wonderful.pipeline.for.item.2" : {
>        "events" : [
>                     "pipeline process 1": "success",
>                     "pipeline process 2": "success",
>                     "pipeline process 3": "success",
>                     "pipeline process 4": "success",
>                     "pipeline process 5": "success"
>                    ]
>      }    
>   }
   
One can include tracebacks for these analysis. The document then looks like:

>   {
>     "my.wonderful.pipeline.for.item.1" : {
>        "events" : [
>                     "pipeline process 1": {"state": "success"},
>                     "pipeline process 2": {"state": "success"},
>                     "pipeline process 3": {"state": "failed", "traceback": "All the wonderful traceback",
>                    ]
>      },



