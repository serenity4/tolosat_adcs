#!/bin/bash
# Gets data from files

file=$1
depth='-n +2'
# depth='-4'
x=$(cat $file | tail -n +2 | awk '{print $'7' $'3'}')
cat $file | tail $depth | awk '{print $'2'}' > './src/temp/t.txt'
cat $file | tail $depth | awk '{print $'8'}' > './src/temp/vx.txt'
cat $file | tail $depth | awk '{print $'9'}' > './src/temp/vy.txt'
cat $file | tail $depth | awk '{print $'10'}' > './src/temp/vz.txt'
cat $file | tail $depth | awk '{print $'11'}' > './src/temp/x.txt'
cat $file | tail $depth | awk '{print $'12'}' > './src/temp/y.txt'
cat $file | tail $depth | awk '{print $'13'}' > './src/temp/z.txt'

output_path='./src/positions/JSON/'
basename=${file##*/}
output_name=$(echo "$basename" | rev | cut -c5- | rev)
output=$output_path$output_name.json
python3 ./src/txt_to_json.py -ofile $output

rm -f ./src/temp/*.txt
