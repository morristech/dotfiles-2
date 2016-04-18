# get the number of methods in a dex-file
function dex_method_count() {
  cat $1 | head -c 84 | tail -c 4 | hexdump -e '1/4 "%d\n"'
}

# get the number of methods in a dex file by package
function dex_method_count_by_package() {
  dir=$(mktemp -d -t dex)
  baksmali $1 -o $dir > /dev/null
  for pkg in `find $dir/* -type d`; do
    smali $pkg -o $pkg/classes.dex > /dev/null
    count=$(dex_method_count $pkg/classes.dex)
    name=$(echo ${pkg:(${#dir} + 1)} | tr '/' '.')
    echo -e "$count\t$name"
  done
  rm -rf $dir
}

function emu() {
  green=$(tput setaf 64)
  reset=$(tput sgr0)

  # is VBoxManage available on the machine?
  if hash VBoxManage 2>/dev/null; then
    # print the emu:
    echo "${green}"
    echo '
    /-/-=/-=
    //  ZX   "
  / /XZXZX(o)  ---,
  / XZXZXZXZX _____`\
   /ZXZXZXZX
    / ;,ZXZ    EMU-lators
    /  :ZX%\
    /%  : X\
    :/:  %:X:"'
    echo "${reset}"

    echo "${green}VirtualBox VMs available:${reset}"
    echo ""

    # create list of emulators, remove quotes
    emulator_list="$(VBoxManage list vms | sed -e 's/"//g')"

    # iterate through the list of VMs
    let i=0
    emulators=()
    while read -r line; do
      (( i ++ ))
      [[ "$line" =~ (.*)\ {.*} ]]
      emulators[i]=$line
      echo "${green}$i${reset}: ${BASH_REMATCH[1]}"
    done <<< "$emulator_list"

    echo ""
    echo "${green}Choose a device by number (1 - $i) or separate multiple choices by a space (\"1 3 4\") to launch multiple emulators:${reset}"
    echo ""

    read -a choices

    echo ""

    for choice in "${choices[@]}"; do
      # device_serial=[[ $device =~ {(.*)}$ ]] && echo ${BASH_REMATCH[1]}
      [[ "${emulators[$choice]}" =~ (.*)\ {.*}$ ]]
      device_name=${BASH_REMATCH[1]}

      echo "${green}Using $device_name${reset}"
      nohup /Applications/Genymotion.app/Contents/MacOS/player.app/Contents/MacOS/player --vm-name "$device_name" &> /dev/null &
    done
  else
    red=$(tput setaf 124)
    echo "${red}Cannot retrieve list of Genymotion emulators. VirtualBox's VBoxManage must be available.${reset}"
  fi
}

# pass text input to connected android device/emulator
function adbi() {
  adb shell input text $1
}

# run an adb command on all devices found by "adb devices"
# source: http://stackoverflow.com/questions/17882474/running-adb-commands-on-all-connected-devices
function adball() {
  # -t  = print command before running, 
  # -J% = replace the '%' with the value from the left side 
  #       of the pipe ('cut -f 1' = device's serial #),
  # -n1 = use at most one arg with each invocation of the command,
  # -P5 = use up to 5 parallel processes to run simultaneously
  adb devices | egrep '\t(device|emulator)' | cut -f 1 | xargs -t -J% -n1 -P5 \
      adb -s % "$@"
}

# private function
function __get_filename() {
  filename=$1

  # default filename if not set
  if [ ! "$filename" ]; then
      filename="screen"
  fi

  echo $filename
}

# capture android screenshot:
function adbcap() {
  filename=$( __get_filename $1 )
  adb $2 shell screencap -p | perl -pe 's/\x0D\x0A/\x0A/g' > ./$filename.png
}

# capture android screenshot and resize it:
function capsize() {
  filename=$( __get_filename $1 )
  size=$2
  if [ ! "$size" ]; then
    size=360
  fi
  adbcap $filename && sips --resampleWidth $size $filename.png
}

# resize video using ffmpeg and make into GIF
function ffmpeg_resize() {
  video=$1
  width=$2
  output=$3

  # default message if not set
  if [ ! "$video" ]; then
    echo "No video file specified."
    echo
    echo "Usage:"
    echo "ffmpeg_resize video-file (required) width (required) output-file (optional)"
    return -1
  fi
  
  if [ ! "$width" ]; then
    echo "Resize width must be specified. Height will be resized to maintain aspect ratio."
    return -1
  fi

  # default to score-details if app_link is not set
  if [ ! "$output" ]; then
    output="output.gif"
  fi

  ffmpeg -i $video -vf scale=$width:-1 $output
}
