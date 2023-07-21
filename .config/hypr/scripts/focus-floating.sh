floating=true
while getopts "n" o; do
  case "${o}" in
    n)
      floating=false
      ;;
    *)
      usage
      ;;
  esac
done
activewindow_address=0x$(hyprctl activewindow | head -n 1 | cut -f 2 -d ' ')
activeworkspace_id=$(hyprctl activeworkspace | head -n 1 | cut -f 3 -d ' ')
floating_addresses=$(hyprctl clients -j | jq -r "map(select(.floating == $floating)) | map(select(.workspace.id == $activeworkspace_id)) | .[].address") &&
{
  next=0
  looped=0
  for address in $floating_addresses; do
    if [ $next -eq 1 ]; then
      hyprctl dispatch focuswindow "address:$address"
      looped=1
      break
    fi
    if [ "$address" == $activewindow_address ]; then
      next=1
    fi
  done
  [ $looped -eq 0 ] &&  hyprctl dispatch focuswindow "address:$(echo $floating_addresses | cut -d ' ' -f 1)"
}
