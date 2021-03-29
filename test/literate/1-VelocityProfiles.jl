#=
# Velocity profiles
In this notebook, we will discuss a useful way to visualize a flow in fluid
mechanics: the **velocity profile**.
=#
#-

# ### Set up the module
using ThermofluidQuantities
#-
using Plots

#=
To start, let's consider one of the most basic types of flow: the linear shear flow,
often called **Couette flow**. This type of flow is generated, for example, between
two parallel walls when one wall is moving and the other is stationary. In the figure
below, the top wall is moving with velocity $U$, the lower wall is stationary:

<img src="https://raw.githubusercontent.com/UCLAMAEThreads/MAE103/master/notebook/Couette.svg" alt="velocity profile" width="300" align="center"/>

Because of the **no-slip condition**, the fluid next to each wall moves with it. The
fluid next to the upper wall moves at velocity $U$, the fluid next to the lower wall
is at rest.

The velocity profile depicts $u(y)$, the horizontal component of velocity as a
function of vertical position, $y$. This increases linearly from the lower to the
upper wall. In fact, the function is just

$$u(y) = Uy/H$$

The arrows indicate the direction that the fluid is moving, and the lengths of
the arrows indicate the relative speed at that $y$ position.
=#
#-
#=
### Plotting velocity profiles
The arrows are helpful, but you can also plot a velocity profile without them.
For example, consider the following velocity:

$$u(y) = \frac{4U_c}{H^2} y (H - y)$$

The coefficient $U_c$ is a speed, and $H$ is the gap height.
=#
#=
Let's define a function that evaluates this velocity. Here, `y`, `Uc`, and `H`
are to be given as arguments to the function.
=#
u(y,Uc,H) = 4*Uc/H^2*y*(H-y)

#=
Suppose the gap height $H$ is 1 cm and the speed $U_c$ is 1 m/s. We will evaluate
this velocity at a range of locations between 0 and $H$:
=#
H = 1u"cm"  # 1 cm = 0.01 m
Uc = 1u"m/s"
y = range(0u"cm",H,length=101) # 101 points to evaluate at, just to make it look smooth.

#=
Now we evaluate the velocity function at the range of $y$ locations. (Remember that
the `.` vectorizes the evaluation of a function.)
=#
v = Velocity.(u.(y,Uc,H))

#=
Notice that $u$ is 0 at the beginning and end of the range. Let's plot it. But
let's plot it as a velocity profile, which means we make $u$ the 'x' axis and $y$
the 'y' axis.
=#

plot(v,y,xlim=(0u"m/s",2Uc),ylim=(0u"cm",H),
    legend=false,xlabel="u(y)",ylabel="y")
#=
The top and bottom of this plot suggest that these are stationary walls where the
flow is at rest. In fact, this is the velocity profile associated with pressure-driven
flow through the gap.
=#
