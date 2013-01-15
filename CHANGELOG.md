## 0.0.6

 * Clarified documentation
 * Fixed "WARNING: This way of doing signal handling is now deprecated. Please see http://hone.heroku.com/resque/2012/08/21/resque-signals.html for more info."

## 0.0.5

 * Unknown (to be updated later)

## 0.0.4

 * Add a :vverbose option to distinguish from the :verbose option
 * Add a timeout when killing Resque, to force it with SIGKILL
 * Change the way the #spawn call is made, so it doesn't create a subshell to launch
   Resque, which was causing issue #2

## 0.0.3

 * Forked from guard-delayed and started guard-resque


-- guard-delayed --

## 0.1.0 (2011-07-28)

 * Fixed options for current delayed_job version (from dbloete)
 * Environment settings needed to be passed in via RAILS_ENV=

## 0.0.9 (2011-06-22)

 * Fixed argument passing to the start script
 * Cleaned up some documentation.

## 0.0.8 (2011-05-24)

 * Changed template to include :environment => 'development'
 * Changed name from 'guard-delayed_job' to 'guard-delayed'
 * Fixed options passing

## 0.0.3 (2011-05-23)

 * Initial release.
