#!/usr/bin/env bash

DISP_CONFS=$(xfconf-query -c displays -l |grep -Po "^/[^/]+(?=/)"|sort -u)

get_name() {
	xfconf-query -c displays -p $1 2>/dev/null |tr -d '\n' && echo " ($1)"|| echo "$1"
}

get_connected() {
	xfconf-query -c displays -p $1 -l|grep -Po "(?<=^$1/)[^/]+$" | sort -u
}

is_active() {
	if [[ $(xfconf-query -c displays -p $1/$2/Active) == true ]]; then
		return 0
	else
		return 1
	fi
}

get_resolution() {
	xfconf-query -c displays -p $1/$2/Resolution |tr -d '\n'
}
get_pos() {
	xfconf-query -c displays -p $1/$2/Position/X |tr -d '\n'
	echo -n "x"
	xfconf-query -c displays -p $1/$2/Position/Y |tr -d '\n'
}

get_rotate() {
	ROTATION="$(xfconf-query -c displays -p $1/$2/Rotation)"
	case "$ROTATION" in
		90)
			echo "left"
		;;
		180)
			echo "inverted"
		;;
		270)
			echo "right"
		;;
		*)
			echo "normal"
		;;
	esac
}

echo "#!/usr/bin/env bash"
echo 'CONNECTED="$(xrandr |grep -Po "^.*(?= connected)")"'

for C in $DISP_CONFS; do
	CMD="xrandr"
	echo "# $(get_name $C)" 
	echo "# Connected / Active-setting:"
	DISP_CONN="$(get_connected $C)"
	THE_IF="if true"
	for D in $DISP_CONN; do
		THE_IF="$THE_IF && [[ \$CONNECTED == *${D}* ]]"
		if is_active $C $D; then
			CMD="$CMD --output $D --mode $(get_resolution $C $D) --pos $(get_pos $C $D) --rotate $(get_rotate $C $D)"
			echo "# - $D: Yes"
		else
			CMD="$CMD --output $D --off"
			echo "# - $D: No"
		fi
	done
	echo "$THE_IF ; then"
	echo "echo \"Activating profile: $(get_name $C)\""
	echo "$CMD"
	echo "exit 0"
	echo "fi"
	echo ""
done

