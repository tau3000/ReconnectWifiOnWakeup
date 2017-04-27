#!/bin/sh
dir=$(dirname $0)
pgrep -q -f 'awakened.*networksetup' || $dir/awakened /bin/sh -c 'networksetup -setairportpower en0 off; sleep 1; networksetup -setairportpower en0 on' &
end
