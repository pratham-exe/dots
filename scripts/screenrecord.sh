#!/usr/bin/env bash
# Toggle screen recording with wf-recorder (Wayland/Hyprland).
#   screenrecord.sh            -> record full screen (with audio)
#   screenrecord.sh region     -> select a region first (slurp)
#   screenrecord.sh region-mute / mute -> record without audio
# Running it again while a recording is active STOPS and saves it.

outdir="$HOME/Videos/recordings"
mkdir -p "$outdir"

# Notification helper: single updating slot (start/stop replace each other).
notify() { # $1=urgency $2=timeout(ms) $3=title $4=body
    notify-send -a "screenrec" -u "$1" -t "$2" \
        -h string:x-canonical-private-synchronous:screenrec \
        "$3" "$4" 2>/dev/null
}

# Already recording? -> stop and finalize.
if pgrep -x wf-recorder >/dev/null; then
    pkill -INT -x wf-recorder
    notify normal 2000 "⏹ Recording stopped" ""
    exit 0
fi

out="$outdir/rec-$(date +%Y%m%d-%H%M%S).mp4"
args=()
audio=1

case "$1" in
    region|region-mute) geo=$(slurp) || exit 1; args+=(-g "$geo") ;;
esac
case "$1" in
    *mute) audio=0 ;;
esac
[ "$audio" = 1 ] && args+=(-a)

wf-recorder "${args[@]}" -f "$out" &
sleep 0.4
if pgrep -x wf-recorder >/dev/null; then
    notify critical 2000 "⏺ Recording started" ""
else
    notify critical 3000 "⚠ Recording failed" ""
fi
