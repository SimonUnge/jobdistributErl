jobdistributErl
===============

## Must
#### M1
Have makefile which installs Tier one (no couchDB or couchBeam)
#### M2
WM receive Job and execute job
Do job regardless, no claims or checks. Receive a job document containing just one job.
Get job doc
Extract job
Spawn worker
Give worker job
Get result
Return
#### M3
Connect with couchDB
With an interface
#### M4
Work distributed (connected with couchDB), create and 
execute job on some node
#### M5
Install with dependencies

## Should 
#### S1
Have config file, read on startup
#### S2
Have config file, read dynamically
#### S3
Handle crashes
#### S4
Abort jobs
#### S5
Retry failed jobs
## Could
#### C1
Configurable nodes, master node, slave node with different
responsibilities
#### C2
Handle crashing master, slave takeover
## Would
Create job interface 
