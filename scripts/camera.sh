#!/usr/bin/env bash
# Control the built-in-camera bridge (turns the IPU6 sensor into a normal
# webcam at /dev/video42 that any app can use).
#   camera on      start the bridge -> camera available to apps
#   camera off     stop it          -> camera + LED off
#   camera status  show state (default)

svc=camera-relay.service
case "${1:-status}" in
  on)   systemctl --user start "$svc"  && echo "Camera ON  — pick the 'Camera' device in your app.";;
  off)  systemctl --user stop  "$svc"  && echo "Camera OFF — sensor/LED off.";;
  status|*) echo "camera: $(systemctl --user is-active "$svc")";;
esac
