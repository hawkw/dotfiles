#! /bin/sh

kwmc=/usr/local/bin/kwmc
screencapture=/usr/sbin/screencapture

FOCUSED_BORDER=$($kwmc read border focused)
PREFIX_BORDER=$($kwmc read border prefix)
MARKED_BORDER=$($kwmc read border marked)

$kwmc config focused-border disable
$kwmc config prefix-border disable
$kwmc config marked-border disable

$screencapture $@ ~/Desktop/$(date +%s).png

if [ "$FOCUSED_BORDER" = "1" ]
then
    $kwmc config focused-border enable
fi

if [ "$PREFIX_BORDER" = "1" ]
then
    $kwmc config prefix-border enable
fi

if [ "$MARKED_BORDER" = "1" ]
then
    $kwmc config marked-border enable
fi
