import numpy as np
import interpolation.approximations


def spline_control(timeline, control_points):
    spline_evals = []
    n = len(timeline)
    if control_points.shape == 1:
        control_points = np.reshape(control_points, (-1, n))
    l = control_points.shape[0]
    for i in range(l):
        spline_evals += [interpolation.approximations.get_spline(timeline, control_points[i, :])]

    def get_control(t):
        U = np.array([spline_evals[i](t) for i in range(l)])
        return U

    return get_control


if __name__ == "__main__":
    pass
