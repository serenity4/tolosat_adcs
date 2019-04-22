import numpy as np
import matplotlib.pyplot as plt
import json
from numpy import pi

def plot_mat(ifile):
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

def plotly_json(ifile):
    import plotly.offline
    import plotly.graph_objs as go
    with open(ifile, 'r') as ifile:
        simres = json.load(ifile)
    rw_speeds = [simres['rw1_omega'], simres['rw2_omega'], simres['rw3_omega'], simres['rw4_omega']]
    omega_max = 3200*pi/30
    timeline = np.linspace(1, len(rw_speeds[0]), len(rw_speeds[0]))
    data = []
    for i in range(len(rw_speeds)):
        data += [go.Scattergl(
        x = timeline,
        y = rw_speeds[i],
        mode = 'lines',
        name = "RW " + str(i+1)
        )]
    data += [go.Scattergl(
    x = [0, len(timeline)],
    y = [omega_max, omega_max],
    name = "Maximum speed",
    mode = 'lines',
    line = {'color': 'rgb(256, 191, 23)',
            'width': 3,
            'dash': 'dash'}
    )]
    layout = {
    'title': "Reaction wheels speed",
    'xaxis': {'title': "Time (s)"},
    'yaxis': {'title': "RW speed"},
    }
    plotly.offline.plot({'data': data, 'layout': layout})
    # plt.hlines(omega_max, 1, len(rw_speeds[0]), label='maximum speed')

if __name__ == "__main__":
    plotly_json("pythondev/simres_data/simres.json")
