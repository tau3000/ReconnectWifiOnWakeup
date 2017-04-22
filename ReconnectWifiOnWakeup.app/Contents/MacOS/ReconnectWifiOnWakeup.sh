#!/bin/sh
pgrep -q -f 'awakened.*networksetup' || $(basename $0)/awakened /bin/sh -c 'networksetup -setairportpower en0 off; sleep 1; networksetup -setairportpower en0 on' &
end
