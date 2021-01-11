from sympy.physics.vector import ReferenceFrame, dot
from sympy import *

init_printing()

x,y,z = symbols('x y z')

r = symbols('r')

# Rumus Bola
eq1 = Eq(x**2 + y**2 + z**2, r**2)
pprint(eq1)

# Rumus Bola dengan center tidak di tengah
Cx,Cy,Cz = symbols('Cx Cy Cz')
eq2 = Eq((x - Cx)**2 +(y - Cy)**2 + (z - Cz)**2, r **2)
pprint(eq2)

# Representation in Matrix
C = Matrix([Cx, Cy, Cz])
P = Matrix([x, y, z])
rumus_radius_in_matrix = Matrix.dot(P-C, P-C)
pprint(rumus_radius_in_matrix)

eq3 = Eq( Matrix.dot((P-C), (P-C)), r**2)
pprint(eq3)

t = symbols('t')
Dx, Dy, Dz = symbols('Dx Dy Dz')
Ox, Oy, Oz = symbols('Ox Oy Oz')

D = Matrix([Dx, Dy, Dz])
O = Matrix([Ox, Oy, Oz])

eq4 = O + D * t

c, p, d, o = symbols('c p d o')
eq3a = Eq( (p-c) * (p-c), r* r)
pprint(eq3a)

eq5 = eq3a.subs({p: o + d * t})
pprint(eq5)

eq6 = O+t*D-C

eq7 = Matrix.dot( eq6, eq6 ) - r**2
pprint(eq7)
endResult = solve(eq7)
pprint(endResult)

