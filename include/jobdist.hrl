-record(job, {
          target :: string(),
          do :: string(),
          executioner :: string()
         }).
-record(job_document, {
          id :: string(),
          rev :: string(),
          creator :: string(),
          job_status :: string(),
          job :: #job{}
         }).
