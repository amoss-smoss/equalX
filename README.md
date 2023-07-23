Task Description:
Write a script that uses the GitHub API to query a user's publicly available gists.  
When the script is first run, it should display a listing of all the user's publicly available gists.
On subsequent runs the scripty should list any gists that have been published since the last run.
The script may optionally provide other functionality (possibly via command line flags) but tyhe above funtionality must be implemented.

The script provided is gistctrl.sh
Usage: ./gistctl.sh -c [API Command] -u [User name] -S [since yyyy-mm-dd:hh:mm:ssZ]
-c: show (REQUIRED, currently only show is available, fetch and list coming soon)
-u: gist userid (optional, default is all public)
-S: Since format yyyy-mm-dd:hh:mm:ssZ (optioanl)
-t: Your github token (optional can be set in your environment)
NOTE: Your github token can be set in your ENV as GITHUB_TOKEN, or can be supplied on the command line with the '-t' option

gistctl.sh -c show [ -u USERNAME ] [ -S YYYY-MM-DD:HH:MM:SSZ ] [ -t TOKEN TO USE ]
will show all, (or just those belonging to USERNAME), publicly available gists and will set all future invocations to be supplied with a 'Since' value 
that corresponds to the date and time of you first execution of the script.
All subsequent script executions will be using that 'Since' value unless specifically overridden by the -S option
