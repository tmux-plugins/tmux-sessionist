#!/usr/bin/env bash

session_list() {
	tmux list-sessions -F "#{session_name}"
}

output_height() {
	local list="$1"
	echo "$list" |
		wc -l |
		tr -d ' '
}

# calculates required number of columns for the multi-column output
get_column_number() {
	local output_height="$1"
	local pane_height="$2"
	local columns="$(expr $output_height / $pane_height )"
	if [ $(expr $output_height % $pane_height ) -gt 0 ]; then
		columns=$(expr $columns + 1)
	fi
	echo "$columns"
}

get_column_width() {
	declare -a array=("${!1}")
	local width=0
	# searching for the longest session name
	for session_name in "${array[@]}"; do
		if [ ${#session_name} -gt $width ]; then
			width="${#session_name}"
		fi
	done
	# add some padding to the right
	echo $((width + 2))
}

print_multi_column_output() {
	local output_height="$1"
	local pane_height="$2"
	local pane_width="$3"
	local columns="$(get_column_number "$output_height" "$pane_height")"
	eval session_array=( $(tmux list-sessions -F "'#{session_name}'") )
	local width="$(get_column_width session_array[@])"

	# limit number of displayed columns
	local max_columns=$(( $((pane_width + 2)) / $width))
	if [ $columns -gt $max_columns ]; then
		# there's more columns than it fits on the display
		columns="$max_columns"
		# last displayed element indicates there's more
		session_array[$((pane_height * columns - 1))]="..."
	fi

	# Composing a string that prints variable number of columns.
	# Example print_string for 2 columns:
	# printf "%-17s  %s\n" "${session_array[$index]}" "${session_array[$((index + 54 ))]}"
	local first_arg=''
	local arg_list=''
	local i=1
	while [ $i -lt $columns ]; do
		first_arg+="%-${width}s"
		arg_list+=" \"\${session_array[\$((index + $((i * $pane_height)) ))]}\""
		i=$((i + 1))
	done

	local print_string=''
	print_string+='printf "'
	print_string+=$first_arg
	print_string+='%s\n" "${session_array[$index]}"'
	print_string+=$arg_list

	local index=0
	while [ $index -lt $pane_height ]; do
		eval "$print_string"
		index=$((index + 1))
	done
}

main() {
	local pane_height=$(tmux display-message -p -F "#{pane_height}")
	local pane_width=$(tmux display-message -p -F "#{pane_width}")
	local session_list="$(session_list)"
	local output_height=$(output_height "$session_list")
	if [ $output_height -gt $pane_height ]; then
		print_multi_column_output "$output_height" "$pane_height" "$pane_width"
	else
		echo "$session_list"
	fi
}
main
