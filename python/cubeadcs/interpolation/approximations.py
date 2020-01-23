import numpy as np
import scipy.interpolate as spi


def affine_approx(start, end, shape):
    var = np.zeros(shape)
    for i in range(var.shape[0]):
        var[i, :] = start[i] + np.linspace(0, 1, var.shape[1]) * (end[i] - start[i])
    return var


def get_spline(x, y, spline_order=3):
    spline_repr = spi.splrep(x, y, k=spline_order)
    return lambda x: spi.splev(x, spline_repr, der=0)


def read_spline(path, var=1):
    with open(path, 'r') as ifile:
        list_x = []
        list_y = []
        lines = ifile.readlines()
        for i in range(var):
            l1, l2 = lines[2*i:2*(i+1)]
            list_x.append(np.array(list(l1.strip("\n").split(" "))))
            list_y.append(np.array(list(l2.strip("\n").split(" "))))
    return [get_spline(list_x[i], list_y[i]) for i in range(var)]


def spline_approx(x_points, y_points_array, sample_points):
    evals = np.zeros([y_points_array.shape[0], len(sample_points)])
    ders = np.zeros([y_points_array.shape[0], len(sample_points)])
    for i in range(y_points_array.shape[0]):
        spline = spi.splrep(x_points, y_points_array[i, :], s=0)
        evals[i, :] = spi.splev(sample_points, spline, der=0)
        ders[i, :] = spi.splev(sample_points, spline, der=1)
    return evals, ders


if __name__ == "__main__":
    pass
