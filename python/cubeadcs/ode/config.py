import numpy as np
import inspect


def set_control_bounds(lb_fun, ub_fun, lb_args=(), ub_args=()):
    """
    """
    def bound_control(control, lb_args, ub_args):
        lb = lb_fun(*lb_args)
        ub = ub_fun(*ub_args)
        return np.clip(control, lb, ub)


def bound_control(control_lb_fun=None, control_ub_fun=None):
    if control_lb_fun is not None and control_ub_fun is not None:
        lb_args = inspect.signature(control_lb_fun).parameters
        ub_args = inspect.signature(control_ub_fun).parameters
        bound_control = ode.config.set_control_bounds(control_lb_fun, control_ub_fun, lb_args=lb_args, ub_args=ub_args)
    elif control_lb_fun is None:
        ub_args = inspect.signature(control_ub_fun).parameters
        bound_control = ode.config.set_control_bounds(lambda: np.inf, control_ub_fun, lb_args=(), ub_args=ub_args)
    elif control_ub_fun is None:
        lb_args = inspect.signature(control_lb_fun).parameters
        bound_control = ode.config.set_control_bounds(control_lb_fun, lambda: np.inf, lb_args=lb_args, ub_args=())
    else:
        def bound_control(u): return u
    return bound_control


if __name__ == "__main__":
    pass
