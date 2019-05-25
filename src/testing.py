import json
import numpy as np

def get_visibilities(timeline, ranges):
    N = len(timeline)
    last_value = ranges[0]
    t0 = timeline[0]
    visibilities = []
    windows_length = []
    for i in range(1, N):
        value = ranges[i]
        ### adds final point to visibility window if it closes
        if last_value != value and last_value:
            tf = timeline[i-1]
            if t0 != tf: ### just to check we don't count single points
                visibilities += [(t0, tf)]
                windows_length += [tf-t0]
        ### initialize t0 when window opens
        if last_value != value and value:
            t0 = timeline[i]
        last_value = value
    if len(visibilities) != 0:
        min_window = min(windows_length)
        max_window = max(windows_length)
    else:
        min_window = None
        max_window = None
    return visibilities, windows_length, max_window, min_window

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('-save', type=str, default=None, help="Save a copy of the json file with the provided name.")
    parser.add_argument('-ifile', type=str, default='simres', help="Input file, default is simulation result")
    args = parser.parse_args()
    save = args.save
    ifile = args.ifile
    if save is not None:
        save = "src/simres_data/" + args.save + ".json"
    if ifile is not None:
        ifile = "src/simres_data/" + args.ifile + ".json"

    with open(ifile, 'r') as ifile:
        simres = json.load(ifile)

    if save is not None:
        with open(save, 'w') as ofile:
            json.dump(simres, ofile, sort_keys=True, indent=4)

    rw_speeds = simres['results']['rw1_omega']
    N = len(rw_speeds)
    ranges = simres['results']['in_range']
    dt = simres['conf']['time_step']
    timeline = np.linspace(dt, N*dt, N)
    visibilities, windows_length, max_window, min_window = get_visibilities(timeline, ranges)
    if len(visibilities) != 0:
        print(visibilities)
        print(max_window)
        print(min_window)
        print(windows_length)
        print(sum(windows_length))
