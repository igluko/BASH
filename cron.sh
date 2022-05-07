$DST_NODE="1.1.1.1"
SSH="ssh -o BatchMode=yes -o ConnectTimeout=5 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -q root@$DST_NODE"
CRON_FILE="/var/spool/cron/crontabs/root"

## add task to crontab
TASK="* * * * * /root/Sync/wg0-reload.sh 2>&1 | logger -t wg0-reload"
if eval "$SSH 'cat $CRON_FILE | grep -q \"$TASK\"'"
then
    echo "task already has been added to crontab"
else
    eval "$SSH 'echo \"$TASK\" >> $CRON_FILE'"
    echo "add task to crontab"
    eval "$SSH 'service cron reload'"
    echo "reload cron service"
fi
