#!/bin/bash
# Gets data from file

file=$1
depth='-n +2'
# depth='-4'
x=$(cat $file | tail -n +2 | awk '{print $'7' $'3'}')
cat $file | tail $depth | awk '{print $'2'}' > './pythondev/temp/t.txt'
cat $file | tail $depth | awk '{print $'8'}' > './pythondev/temp/vx.txt'
cat $file | tail $depth | awk '{print $'9'}' > './pythondev/temp/vy.txt'
cat $file | tail $depth | awk '{print $'10'}' > './pythondev/temp/vz.txt'
cat $file | tail $depth | awk '{print $'11'}' > './pythondev/temp/x.txt'
cat $file | tail $depth | awk '{print $'12'}' > './pythondev/temp/y.txt'
cat $file | tail $depth | awk '{print $'13'}' > './pythondev/temp/z.txt'

output_path='./pythondev/positions/JSON/'
basename=${file##*/}
output_name=$(echo "$basename" | rev | cut -c5- | rev)
output=$output_path$output_name.json
python3 ./pythondev/txt_to_json.py -ofile $output

rm -f ./pythondev/temp/*.txt
