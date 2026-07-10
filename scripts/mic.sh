#!/usr/bin/env bash
# Microphone helper for PipeWire/PulseAudio + ALSA.
#
#   mic.sh              show default mic status (mute + volume)  [default]
#   mic.sh status       same as above
#   mic.sh list         list all input sources (mics)
#   mic.sh fix          unmute + enable ALSA Capture + set volume 80%
#   mic.sh on|off       unmute / mute the default mic
#   mic.sh toggle       toggle mute on the default mic

src="@DEFAULT_SOURCE@"

case "${1:-status}" in
  list)
    echo "== Input sources (mics) =="
    pactl list sources short | grep -i alsa_input
    echo
    echo "Default mic: $(pactl get-default-source)"
    ;;

  status|check)
    echo "Default mic : $(pactl get-default-source)"
    mute=$(pactl get-source-mute "$src" | awk '{print $2}')
    [ "$mute" = "no" ] && echo "State       : ON  (unmuted)" || echo "State       : OFF (muted)"
    echo "Volume      : $(pactl get-source-volume "$src" | grep -oE '[0-9]+%' | head -1)"
    echo "ALSA Capture: $(amixer get Capture 2>/dev/null | grep -oE '\[(on|off)\]' | head -1)"
    ;;

  fix)
    pactl set-source-mute "$src" 0
    amixer set Capture cap  >/dev/null 2>&1   # enable ALSA capture switch
    amixer set Capture 80% unmute >/dev/null 2>&1
    pactl set-source-volume "$src" 80%
    echo "Mic fixed: unmuted, ALSA Capture enabled, volume 80%."
    echo
    "$0" status
    ;;

  on)     pactl set-source-mute "$src" 0; echo "Mic ON (unmuted)";;
  off)    pactl set-source-mute "$src" 1; echo "Mic OFF (muted)";;
  toggle) pactl set-source-mute "$src" toggle; "$0" status;;

  *) echo "usage: mic.sh {status|list|fix|on|off|toggle}"; exit 1;;
esac
