#!/bin/bash

# Install cron job
echo '* * * * * root curl --user staffjoydev: http://suite.local/api/v2/internal/cron/' >> /etc/crontab
