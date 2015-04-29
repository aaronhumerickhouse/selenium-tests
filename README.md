#Selenium-Tests
This module holds acceptance tests using Watir Web-Driver, an extension of Selenium Web-Driver.  

##Test Execution
To execute the tests, use these commands.

###Single Execution
####Local	

	bundle exec rake spec["<PATTERN>, <OPTIONS>"]
	
####Sauce Labs

	DRIVER=sauce bundle exec rake sauce_spec["<PATTERN>, <OPTIONS>"]
	
###Parallel Execution
#### Local

    bundle exec rake parallel_spec["<PATTERN>, <TAGS>, <FORKS>, <OPTIONS>"]
 
#### Sauce Labs    
    DRIVER=sauce bundle exec rake parallel_spec["<PATTERN>, <TAGS>, <FORKS>, <OPTIONS>"]
    

#### Configurations
##### Browser
In the command line, prior to the command enter:
    
    BROWSER=<browser>
    
Browser Options include:

- chrome
- firefox
- ie

If BROWSER is not defined, execution defaults to Firefox.

##### RSpec Options
Specify specific file patterns to run.

    --pattern <ANT pattern>
    -P <ANT pattern>
    
Run specs with specific tags

    --tag <TAG>
    -t <TAG>
    
Don't stop running an entire spec based on one example

    --no-fail-fast
 
Results output format

    --format <FORMAT>
options include:

* progress (default)
* documentation
* html
* json

This can be duplicated.


Results output file

    --out <output file for results>
    

##### Environment
In the command line prior to the command enter:
    
    ENVIRONMENT=<environment>

Environment Options include:

- staging

Defaults to staging.

##Contributing
###Git
You've been assigned AUT-123, mapping the Dashboard page

the game score does not properly update (To install op see https://github.com/sportngin/octopolo/blob/master/README.markdown).

1. `op new-branch aut-123-map-dashboard`
    * Create page-object and test.
2. `git commit -a -m "123 - Mapped Dashboard to Page Object"`
    * Commits to local git repository.
3. `git push`
    * Sends your commit(s) to github.
4. `op pull-request`
    * Creates a new pull request.
    * Answer the questions and fill out the template.
    * Often useful to edit the pull request in the browser after it is created, to fill out various sections such as QA Plan, Deploy Plan, etc.
5. Find another developer on your team to code review your pull request.
    * Once Code Review has occurred within the pull request, move on to the next step.
    * `op signoff CR` can be used to indicate signoff.
    * Note: This should be done by the reviewing developer.
6. `git checkout master`
    * Returns to the master branch
7. `op sync-branch aut-123-map-dashboard`
    * Merges `aut-123-map-dashboard` into `master`

## Documentation
In the command line from the project root enter:

      yardoc
    
   



  
