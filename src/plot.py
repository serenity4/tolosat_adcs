import numpy as np
import matplotlib.pyplot as plt
import json
from numpy import pi
from .testing import get_visibilities

def save(simres, ofile):
    if not(ofile.endswith('json')):
        ofile += '.json'
        ofile = "src/simres_data/" + ofile

    with open(ofile, 'w+') as tosave:
        json.dump(simres, tosave)

def add_rw(simres, data, timeline):
    """Adds reaction wheel plots to the data
    """
    rw_speed = simres['results']['rw1_omega']

    data.append(go.Scattergl(
    x = timeline,
    y = rw_speed,
    mode = 'lines',
    name = "RW 1"
    ))
    data.append(go.Scattergl(
    x = [0, N*dt],
    y = [omega_max, omega_max],
    name = "Maximum speed",
    mode = 'lines',
    line = {'color': 'rgb(256, 191, 23)',
            'width': 3,
            'dash': 'dash'}
    ))
    # plt.hlines(omega_max, 1, len(rw_speeds[0]), label='maximum speed')



def plotly_json(ifile, save_name=None):
    """
    Plots simulation outputs from a .json file (Plotly plots)

    Args:
        ifile (str): Input file for post-processing;
        save (str): Output file for saving
    """
    import plotly.offline
    import plotly.graph_objs as go
    with open(ifile, 'r') as ifile:
        simres = json.load(ifile)

    ### save file is the option is provided

    if save_name is not None:
        save(simres, ofile=save_name)

    dt = simres['conf']['time_step']
    N = int(simres['conf']['end']/dt)
    timeline = np.linspace(dt, N*dt, N)
    in_range = simres['results']['in_range']
    omega_max = 3200*pi/30
    data = []

    data.append(go.Scattergl(
    x = timeline,
    y = in_range,
    name= "In range",
    mode = 'lines',
    xaxis='x2',
    yaxis='y2'
    ))
    layout = {
    'title': "TOLOSAT ADCS RESULTS",
    'xaxis': {'title': "Time (s)", 'domain': [0, 0.45]},
    'yaxis': {'title': "Visiblity"},
    # 'xaxis2': {'title': "Time (s)", 'domain': [0.55, 1]},
    # 'yaxis2': {'anchor': 'x2'},
    }
    plotly.offline.plot({'data': data, 'layout': layout})
    visibilities, windows_length, max_window, min_window = get_visibilities(timeline, in_range)
    if len(visibilities) != 0:
        print("Visibility windows: {}".format(visibilities))
        print("Maximum window: {}".format(max_window))
        print("Minimum window: {}".format(min_window))
        print("Windows length: {}".format(windows_length))
        print("Overall windows length: {}".format(sum(windows_length)))
        print("Overall visibility ratio: {}".format(sum(windows_length)/simres['conf']['end']))

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('-save', type=str, default=None, help="Save a copy of the json file with the provided name.")
    parser.add_argument('-ifile', type=str, default='simres', help="Input file, default is simulation result")
    args = parser.parse_args()
    save_name = args.save
    ifile = args.ifile
    if save_name is not None:
        save_name = "src/simres_data/" + args.save + ".json"
    if ifile is not None:
        ifile = "src/simres_data/" + args.ifile + ".json"

    plotly_json(ifile, save_name=save_name)
