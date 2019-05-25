import numpy as np
import numpy.linalg as npl
import matplotlib.pyplot as plt

I = np.array([0.0136, 0.0134, 0.0046])

mu = 3.986e14
R = (6370 + 400)*1e3
omega = np.sqrt(mu/R**3)

import pdb; pdb.set_trace()

def C(phi, theta):
     return 3*omega*np.array([(I[0] - I[1])*phi, (I[2] - I[0])*theta, 0])

ang_range = np.pi/180 * np.array([-10, 10])

n = 100
theta = np.linspace(ang_range[0], ang_range[1], n)
phi = np.linspace(ang_range[0], ang_range[1], n)

Cx = np.zeros((n, n))

X, Y = np.meshgrid(theta, phi)
for i in range(n):
    for j in range(n):
        Cx[i, j] = npl.norm(C(theta[i], phi[j]))

plt.figure()
# plt.contourf(X, Y, Cx)
# import pdb; pdb.set_trace()
plt.plot(phi, Cx[0, :])
plt.show()
