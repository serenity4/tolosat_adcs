import ode.config
import inspect
import ode.utils
import Trajectory
import numpy as np
import interpolation.approximations


def RK4(states, controls, t, step, f):
    """RK4 method for solving ODEs
    Args:

    Returns:
        State at next timestep

    """

    k1 = f((states, controls, t))
    k2 = f((states + k1 * step/2, controls, t + step/2))
    k3 = f((states + k2 * step/2, controls, t + step/2))
    k4 = f((states + k3 * step, controls, t + step))
    next_states = states + (k1 + 2*k2 + 2*k3 + k4)*step/6
    return next_states


class OdeClass():
    def __init__(self, start_states, ode, t0, tf, control_fun=None, control_points=None, interpolation='spline', timestep=None, n_steps=None):
        """
        ode must take (state, controls, time) as single argument
        control_fun must take (time, state) as single argument
        """
        # self.bound_control = ode.config.bound_control(control_lb_fun, control_ub_fun)
        self.t0 = t0
        self.tf = tf

        assert (timestep is not None or n_steps is not None), "Please provider either a timestep or a number of steps."
        if n_steps is not None:
            self.timeline = np.linspace(t0, tf, n_steps)
            self.timestep = self.timeline[1] - self.timeline[0]
            self.n_steps = n_steps
        else:
            self.n_steps = int((tf - t0) / timestep) + 1
            self.timeline = np.linspace(t0, tf, self.n_steps)
            self.timestep = timestep

        assert (np.allclose(self.timeline[-1], tf)), "Last point from timeline does not match the provided end time."

        assert (control_fun is not None or control_points is not None), "Please provide either a control function or control points to fit with an interpolant."

        if control_fun is not None:
            self.control_fun = control_fun
            self.control_points = None
            self.n_controls = len(self.control_fun((t0, start_states)))
        else:
            self.control_fun = None
            self.control_points = control_points
            self.n_controls = (control_points[1]).shape[0]

        self.n_states = len(start_states)
        self.ode = ode

        self.states = np.zeros([self.n_states, self.n_steps])
        self.states[:, 0] = start_states
        self.controls = np.zeros([self.n_controls, self.n_steps])

    def simulate(self):
        if self.control_fun is None:
            self.controls, _ = interpolation.approximations.spline_approx(*self.control_points, self.timeline)
        for i in range(self.n_steps - 1):
            if self.control_fun is not None:
                self.controls[:, i] = self.control_fun((self.timeline[i], self.states[:, i]))
            self.states[:, i + 1] = RK4(self.states[:, i], self.controls[:, i], self.timeline[i], self.timestep, self.ode)

        if self.control_fun is not None:
            self.controls[:, -1] = self.control_fun((self.timeline[i], self.states[-1]))

    def export_results(self):
        results = Trajectory.Trajectory()
        results.set_data(timeline=self.timeline, controls=self.controls, states=self.states)
        results.to_array()
        return results


if __name__ == "__main__":
    pass
