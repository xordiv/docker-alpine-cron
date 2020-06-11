# docker-alpine-cron

Dockerfile and scripts for creating image with Cron based on Alpine  
Installed packages: dcron wget rsync ca-certificates  

#### Environment variables:

**CRON_STRINGS** - strings with cron jobs. Use "\n" for newline (Default: undefined)   
**CRON_TAIL** - if defined the cron log file will be sent to *stdout* by *tail*. Additionally, if set to the value *no_logfile*, no log file will be created and logging will be to *stdout* only. (Default: undefined)   
**CRON_CMD_OUTPUT_LOG** - if defined the output of the commands executed by cron will also be sent to *stdout*, otherwise they will be ignored (Default: undefined)

crond always runs in the foreground  

#### Cron files
- /etc/cron.d - place to mount custom crontab files  

When image runs, files in */etc/cron.d* will copied to */var/spool/cron/crontab*.   
If *CRON_STRINGS* defined script creates file */var/spool/cron/crontab/CRON_STRINGS*  

#### Log files
Unless *CRON_TAIL* is set to *no_logfile*, the log file will be placed in /var/log/cron/cron.log.

#### Simple usage:
```
docker run --name="alpine-cron-sample" -d \
-v /path/to/app/conf/crontabs:/etc/cron.d \
-v /path/to/app/scripts:/scripts \
xordiv/docker-alpine-cron
```

#### With scripts and CRON_STRINGS
```
docker run --name="alpine-cron-sample" -d \
-e 'CRON_STRINGS=* * * * * /scripts/myapp-script.sh'
-v /path/to/app/scripts:/scripts \
xordiv/docker-alpine-cron
```

#### Get URL by cron every minute
```
docker run --name="alpine-cron-sample" -d \
-e 'CRON_STRINGS=* * * * * wget --spider https://sample.dockerhost/cron-jobs'
xordiv/docker-alpine-cron
```
