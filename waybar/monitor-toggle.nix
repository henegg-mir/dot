{writeShellScript, monitor }:

writeShellScript "monitor-toggle" ''
  MONITOR=${monitor}
  LEN=$(swaymsg -t get_outputs | jq -r .'|length')

  for ((i = 0; i < LEN; i++)); do
  SERIAL=$(swaymsg -t get_outputs | jq -r .'['$i'].serial')
  if ((MONITOR == SERIAL)); then
  CURRENT=$i
  break
  fi
  done

  ACTIVE=$(swaymsg -t get_outputs | jq -r .'['"$CURRENT"'].active')
  NAME=$(swaymsg -t get_outputs | jq -r .'['"$CURRENT"'].name')

  if [ "$ACTIVE" = "true" ]; then
  (swaymsg output "$NAME" disable)
  else

  (swaymsg output "$NAME" enable)
  fi
''
