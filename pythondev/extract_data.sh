#!/bin/bash
# Gets data from file

file=$1
depth='-n +2'
# depth='-4'
# x=$(cat $file | tail -n +2 | awk '{print $'7' $'3'}')
cat $file | tail $depth | awk '{print $'7'}' > './pythondev/temp/t.txt'
cat $file | tail $depth | awk '{print $'8'}' > './pythondev/temp/x.txt'
cat $file | tail $depth | awk '{print $'9'}' > './pythondev/temp/y.txt'
cat $file | tail $depth | awk '{print $'10'}' > './pythondev/temp/z.txt'
cat $file | tail $depth | awk '{print $'11'}' > './pythondev/temp/vx.txt'
cat $file | tail $depth | awk '{print $'12'}' > './pythondev/temp/vy.txt'
cat $file | tail $depth | awk '{print $'13'}' > './pythondev/temp/vz.txt'

python3 ./pythondev/txt_to_mat.py -ofile ./pythondev/positions/JSON/positions.json

rm -f ./pythondev/temp/*.txt
