#! /bin/bash
#
## An eye averter(literally!)

# Copyright (C) 2019-2020 eye-protector.sh authors (see AUTHORS file)

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


######################################################################################################################
# Contributions Specifications :
# --------------------------------------------------------------------------------------------------------------------
# This script follows google's shell styling guidance(Except the indentation specifications, which I strongly defy!).
# https://google.github.io/styleguide/shell.xml
#
# Use tabs space rather than 2 spaces as oppposed to the specifications in the guide(I love tabs <3). 
# Maintain TODOs and comments inside complex implementations.
# Use double quotes and curly brackets for variable declaration. 
# Use single quotes for strings where no substitution is required.
# Constants and exported variables should be capitalised.
# "Rome was not built in a day."
#
# Lastly, screw any specification you don't like. They are meant as a guide, which you can always ignore. 
#---------------------------------------------------------------------------------------------------------------------
#######################################################################################################################

# Constants
VERSION=1.0


# Global variables
contrast=0.2
exp_time=3
dim_time=10
freq_time=10

function help() {
	# Here-text
cat << EOF
Usage:
  eye-protector.sh [OPTION...]
Help Options:
  -h, --help                        Show help options
Application Options:
  -b, --background		    Start application in background and across sessions
  -c, --close			    Close/kill the application
  -v, --version                     Version of the package.
EOF
}


function notif() {
	# TODO
	# --expire-time option is a known bug(see man pages).
	# Use of other alternatives for prolonged notification display required.
	
	# Below line won't work due to a known bug.
	# (https://bugs.launchpad.net/ubuntu/+source/notify-osd/+bug/390508).
	#
	# read -ep "Duration for notification to appear: " exp_time  
	notify-send --urgency=normal \
	    --hint int:transient:1 \
	    --expire-time="${exp_time}" "EYE-PROTECTOR \"ALERT\"" "Avert your damn eyes, NOW!!!!"
	sleep "${freq_time}"m
}


function brightness_util() {
	
	## Uncomment below line to provide a manual brightness to the screen
	# read -ep "Dimmed brightness value: " contrast

	screen_name=$(xrandr | grep " connected" | cut -f1 -d " ")
	xrandr --output "${screen_name}" --brightness "${contrast}"

}


function time_util() {

	# read -ep "Duration of aversion(in minutes): " dim_time
	# echo "${dim_time} "

	$(brightness_util)
	
	sleep "${dim_time}"m
	local contrast=0.7

	## Uncomment below line to provide a manual brightness to the screen
	# read -ep "Normal brightness value: " contrast

	$(brightness_util)	

}

function terminate() {

	# The [] in grep is a trick which hides the actual grep process itself.
	kill $(ps -efj | grep "[/]bin/bash ./eye-protector.sh" | awk 'NR==1 {print $2}')
}


function main() {
	while [[ $# -gt 0 ]]; do
		case "$1" in 
			-h | --help)
				help
				;;

			-v|--version)
            			echo "${VERSION}"
           			;;

				
	    		-b | --background)
				read -ep "Frequency of repetetion(in minutes)" freq_time
	      			$0 &
				exit 0 
				;;

			-c | --close)
				$(brightness_util)
				$(terminate)
				exit 0
				;;
				
	  		*) 
				exit 1
				;;
	  	esac
		shift
	done

	while : ; do
		$(notif)
		$(time_util)
		sleep "${freq_time}"m 
	done
}


main "$@"
