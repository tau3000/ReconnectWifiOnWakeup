#!/bin/sh
cd $(dirname $0)

APPNAME='WiFiReconnect'
AIRPORT='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'
DEVICE=$(networksetup -listallhardwareports | grep -A1 '^Hardware Port: Wi-Fi' | grep '^Device:' | head -1 | awk '{print $2}')
DEVICE=${DEVICE:-en0}
NOTIFIER_OPT="-sender io.github.tau3000.WiFiReconnect -title $APPNAME -execute : -timeout 5"

if pgrep -q -f 'awakened.*networksetup'; then
  ./terminal-notifier -message "Already running (device $DEVICE)" $NOTIFIER_OPT &
else
  ./awakened /bin/sh -c "$AIRPORT -I | grep -qi 'airport: off' || (networksetup -setairportpower $DEVICE off; sleep 1; networksetup -setairportpower $DEVICE on; ./terminal-notifier -message 'Wi-Fi was reconnected' $NOTIFIER_OPT)" &
  ./terminal-notifier -message "Wi-Fi will be reconnected on wakeup from sleep (device $DEVICE)" $NOTIFIER_OPT &
fi
