"""Calculates inertia.
"""

import numpy as np
r = 5e-2  # cm
h = 20e-2  # cm
m = 2  # kg

Ix = Iy = 1/12 * m * (3*r**2 + h**2)
Iz = 1/2 * m * r**2

print(np.diag([Ix, Iy, Iz]))
