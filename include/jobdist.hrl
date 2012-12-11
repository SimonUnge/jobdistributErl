
-record(job, {
          target :: string(),
          do :: string()
         }).
-record(job_document, {
          creator :: string(),
          step :: integer(),
          job_list :: [#job{}]
         }).
