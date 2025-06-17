#!/bin/bash

EVENT="$1"
DATE=$(date)
LOGFILE="/var/log/nut-events.log"
EMAIL_TARGETS="targets@domain.com"
UPS_NAME="upsname"

echo "[$DATE] Received event: $NOTIFYTYPE - $EVENT" >> $LOGFILE

BODY="UPS event occurred
        Event: $EVENT
        Date: $DATE
        Host: $(hostname)
UPS Status:
$(upsc $UPS_NAME )
"

case "$NOTIFYTYPE" in
  ONBATT)
    echo "Power failure detected. Sending alert..." >> $LOGFILE
    echo "$BODY" | mutt -s "UPS Notification: Power Failure" $EMAIL_TARGETS
    ;;
  ONLINE)
    echo "Power restored. Sending recovery alert..." >> $LOGFILE
    echo "$BODY" | mutt -s "UPS Notification: Power Restored" $EMAIL_TARGETS
    ;;
  LOWBATT)
    echo "Battery is low!" >> $LOGFILE
    echo "$BODY" | mutt -s "UPS Notification: Battery critical" $EMAIL_TARGETS
    ;;
  FSD)
    echo "Forced shutdown initiated" >> $LOGFILE
    echo "$BODY" | mutt -s "UPS Notification: shutdown initiated" $EMAIL_TARGETS
    #/usr/local/sbin/shutdown-handling.sh
    ;;
  *)
    echo "Unhandled event: $EVENT" >> $LOGFILE
    echo "$BODY" | mutt -s "UPS Notification: $EVENT" $EMAIL_TARGETS
    ;;
esac

