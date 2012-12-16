-record(job, {
          target :: string()
          ,do :: string()
          ,executioner :: string()
         }).
-record(job_document, {
          creator :: string()
          ,job_status
          ,job :: #job{}
         }).
