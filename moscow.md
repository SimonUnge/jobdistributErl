jobdistributErl
===============
## Moscow
### Must
#### Have makefile to install and get dependencies
Get couchbeam, couchDB
#### Connect to couchDB
#### Read, correctly formatted(possibly mocked), couchDB document
#### Update couchDB document
#### Claim job
#### Pick job winner
#### Report status
#### Create job*
#### Execute job(s) defined in couchDB document

### Should
#### Abort jobs
#### Hanlde crashes
Restarts, honour commitments or back out
#### Have configure file
Dynamic numb workers
#### Handle work retries

### Could
#### Have alternative jobs
#### Configurable roles
Master/slave nodes, take overs

### Would
#### 

# Timeplan
## Week 1
### Must
#### Have makefile to install and get dependencies
Get couchbeam, couchDB
#### Read, correctly formatted(possibly mocked), couchDB document
#### Update couchDB document

### Should
#### Have configure file

###Could

###Would

## Week 2
### Musts
#### Connect to couchDB
#### Claim job
#### Report status

### Should

###Could

###Would

## Week 3
###Must
#### Pick job winner
#### Execute job(s) defined in couchDB document
#### Create job*

###Should
#### Handle work retries

###Could
#### Have alternative jobs

###Would

## Week 4 
###Must

###Should
#### Abort jobs
#### Hanlde crashes
Restarts, honour commitments or back out

###Could
#### Configurable roles
Master/slave nodes, take overs

###Would