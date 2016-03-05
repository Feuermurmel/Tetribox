#! /usr/bin/env bash

set -e -o pipefail

current_file_name=$1

# This function should be called for each generated file with the file's name as the first argument and the command to call to produce the file's content as the remaining arguments.
function generate_file() {
	file_name=$1
	shift
	generate_command=("$@")
	
	if ! [ "$current_file_name" ]; then
		echo "$file_name"
	elif [ "$current_file_name" == "$file_name" ]; then
		mkdir -p "$(dirname "$file_name")"
		"${generate_command[@]}" > "$file_name"
	fi
}

join() {
	res="$2"
	
	for i in "${@:3}"; do
		res="$res$1$i"
	done
	
	echo "$res"
}

piece() {
	echo "import _$1;"
	echo "$1($(join ', ' "${@:2}"));"
}

for i in {1..15}; do
	generate_file src/divider-$i.asy piece divider $i
	
	for j in 1 2; do
		if [ $[j % 2] -eq 0 ]; then
			generate_file src/side-$i.asy piece side $i 0
		else
			generate_file src/side-$i-a.asy piece side $i 0
			generate_file src/side-$i-b.asy piece side $i 1
		fi
	done
	
	for j in {1..15}; do
		if [ $j -le $i ]; then
			generate_file src/base-$i-$j.asy piece base $i $j
		fi
	done
done

# Call generate_file for each file to be generated.
# E.g.:
# generate_file src/test.scad echo "cube();"
