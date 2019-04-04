import json
import numpy as np
import argparse
import os

def main(args):
    index = ['t', 'x', 'y', 'z', 'vx', 'vy', 'vz']
    dict = {}
    for i in range(len(index)):
        with open('./pythondev/temp/' + index[i] + '.txt', 'r') as ifile:
            dict[index[i]] = np.loadtxt(ifile).tolist()
    with open(args.ofile, 'w') as ofile:
        json.dump(dict, ofile, sort_keys=True, indent=4)


    # t = sio.read('./pythondev/temp/t.txt')
    # x = sio.read('./pythondev/temp/x.txt')
    # y = sio.read('./pythondev/temp/y.txt')
    # z = sio.read('./pythondev/temp/z.txt')
    # vx = sio.read('./pythondev/temp/vx.txt')
    # vy = sio.read('./pythondev/temp/vy.txt')
    # vz = sio.read('./pythondev/temp/vz.txt')



if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("-ofile", type=str, help="output path for JSON file")
    # parser.add_argument("y", type=str)
    # parser.add_argument("z", type=str)
    # parser.add_argument("vx", type=str)
    # parser.add_argument("vy", type=str)
    # parser.add_argument("vz", type=str)
    # parser.add_argument("t", type=str)
    args = parser.parse_args()
    main(args)
