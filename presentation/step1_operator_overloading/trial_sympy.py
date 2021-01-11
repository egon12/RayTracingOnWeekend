# if you in ubuntu maybe need to install
# sympy..
# apt install python3-sympy
# or pip3 install sympy

from sympy import *
init_printing()

# Operator Overload, manipulate definition..
x, y, z = symbols('x y z')
a, b, c = symbols('a b c')

eq1 = a*x**2 + b*x + c
solve(eq1, x)

eq1 = x**2 - 10*x + 25
solve(eq1, x)

eq1 = x**2 - 2*x + 25
solve(eq1, x)

m1 = Matrix([[1,2,3], [4,5,6], [7,8,9]])
mi = Matrix([[1,0,0], [0,1,0], [0,0,1]])

m1 * mi
m1 + mi
m1 - mi
m * 3

