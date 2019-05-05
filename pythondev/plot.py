import numpy as np
import matplotlib.pyplot as plt
import json
from numpy import pi

def plot_mat(ifile):
    """
    TEMPORARY: do not use
    """
    import h5py
    file = h5py.File('PILIA/PROJECTS/tolosat_adcs_kalman/V1/CONF/RW1_speed.mat', 'r')
    data = np.array(file.get('omega'))
    omega_max = 3200*pi/30
    print(data)
    plt.figure()
    plt.plot(data[:,0], data[:,1])
    plt.xlabel('time (s)')
    plt.ylabel('RW1_speed')
    plt.title('Reaction wheel #1 speed')
    plt.hlines(omega_max, data[0,0], data[-1,0], label='maximum speed', color='red')
    plt.legend(loc='lower right')
    plt.show()

def plot_json(ifile):
    """
    Plots simulation outputs from a .json file (matplotlib plots)
    """
    with open(ifile, 'r') as ifile:
        simres = json.load(ifile)
    rw_speeds = [simres['rw1_omega'], simres['rw2_omega'], simres['rw3_omega'], simres['rw4_omega']]
    omega_max = 3200*pi/30
    plt.figure()
    for i in range(len(rw_speeds)):
        plt.plot(rw_speeds[i], label='RW {}'.format(i))
    plt.xlabel('time (s)')
    plt.ylabel('RW speed')
    plt.title('Reaction wheels speed')
    plt.hlines(omega_max, 1, len(rw_speeds[0]), label='maximum speed')
    plt.legend(loc='lower right')
    plt.show()

def plotly_json(ifile, save=None):
    """
    Plots simulation outputs from a .json file (Plotly plots)
    """
    import plotly.offline
    import plotly.graph_objs as go
    with open(ifile, 'r') as ifile:
        simres = json.load(ifile)

    ### save file is the option is provided
    if save is not None:
        with open(save, 'w') as ofile:
            json.dump(simres, ofile, sort_keys=True, indent=4)

    rw_speeds = [simres['rw1_omega'], simres['rw2_omega'], simres['rw3_omega'], simres['rw4_omega']]
    in_range = simres['in_range']
    omega_max = 3200*pi/30
    N = len(rw_speeds[0])
    dt = 1./8
    timeline = np.linspace(dt, N*dt, N)
    data = []
    for i in range(len(rw_speeds)-3):
        data += [go.Scattergl(
        x = timeline,
        y = rw_speeds[i],
        mode = 'lines',
        name = "RW " + str(i+1)
        )]
    data += [go.Scattergl(
    x = [0, N*dt],
    y = [omega_max, omega_max],
    name = "Maximum speed",
    mode = 'lines',
    line = {'color': 'rgb(256, 191, 23)',
            'width': 3,
            'dash': 'dash'}
    )]
    data += [go.Scattergl(
    x = timeline,
    y = in_range,
    name= "In range",
    mode = 'lines',
    xaxis='x2',
    yaxis='y2'
    )]
    layout = {
    'title': "TOLOSAT ADCS RESULTS",
    'xaxis': {'title': "Time (s)", 'domain': [0, 0.45]},
    'yaxis': {'title': "RW speed"},
    'xaxis2': {'title': "Time (s)", 'domain': [0.55, 1]},
    'yaxis2': {'anchor': 'x2'},
    }
    plotly.offline.plot({'data': data, 'layout': layout})
    # plt.hlines(omega_max, 1, len(rw_speeds[0]), label='maximum speed')

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('-save', type=str, default=None, help="Save a copy of the json file with the provided name.")
    args = parser.parse_args()
    save = args.save
    if save is not None:
        save = "pythondev/simres_data/" + args.save + ".json"
    plotly_json("pythondev/simres_data/simres.json", save=save)
