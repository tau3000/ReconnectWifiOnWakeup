#!/bin/sh
dir=$(dirname $0)
airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'

pgrep -q -f 'awakened.*networksetup' || $dir/awakened /bin/sh -c "$airport -I | grep -qi 'airport: off' || (networksetup -setairportpower en0 off; sleep 1; networksetup -setairportpower en0 on)" &
