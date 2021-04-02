# ThermofluidQuantities
*basic tools and definitions of quantities in thermofluids problems*


[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://uclamaethreads.github.io/ThermofluidQuantities.jl/dev/)
 [![Build Status](https://github.com/UCLAMAEThreads/ThermofluidQuantities.jl/workflows/CI/badge.svg)](https://github.com/UCLAMAEThreads/ThermofluidQuantities.jl/actions) [![codecov](https://codecov.io/gh/UCLAMAEThreads/ThermofluidQuantities.jl/branch/main/graph/badge.svg?token=m4pj7rjF0r)](https://codecov.io/gh/UCLAMAEThreads/ThermofluidQuantities.jl)

The purpose of this package is to enable easy setup of quantities in thermofluids problems. It contains
- A large set of specialized types based on common thermofluid quantities
  (e.g. `Velocity`, `Pressure`, etc) that enable dispatch on these
  quantities
- Treatment of typical units, using the [Unitful](https://github.com/PainterQubits/Unitful.jl) package.
- Predefined properties for various common gases and liquids
- Plot recipes for the associated types

### Setting a quantity's value

We can set the value of a quantity through a simple interface, specifying in units with the [Unitful](https://github.com/PainterQubits/Unitful.jl)
interface, or without units, so that it obtains the default units of the quantity. E.g., pressure has default units of Pascals, so we can
set it in, say, atmospheres and it will convert it automatically, or we can just supply a number:
```julia
Pressure(1u"atm")
Pressure(50)
```

### Quantities, units, and types


Quantities of the same units can be added or subtracted, e.g.,

```julia
p = Pressure(1u"atm") + StagnationPressure(3u"atm")
```

The result of this operation is just a [Unitful](https://github.com/PainterQubits/Unitful.jl) quantity. This can then be wrapped by a type with the same units:

```julia
Pressure(p)
```

Quantities with the same units but different names are of different types, so dispatch can distinguish them:

```julia
f(::Pressure) = "I am pressure!"
f(Pressure(5))
```

but this would fail:

```julia
f(StagnationPressure(2.5))
```

### Defining new quantities

The list of predefined dimensional quantities is returned with 

```julia
ThermofluidQuantities.dimvartypes
```

and non-dimensional variables with

```julia
ThermofluidQuantities.nondimvartypes
```

It is simple to define a new quantity and use it. For example, a non-dimnesional variable

```julia
@nondimvar MyDimensionlessNumber
MyDimensionlessNumber(25.3)
```

or a new dimensional quantity

```julia
@dimvar MyTimeVar TimeType
MyTimeVar(2.3u"minute")
```
The second argument represents a 'unit type' for time, a union of types with time units. This comes with a default unit (seconds). To see the list of predefined unit types

```julia
ThermofluidQuantities.unittypes
```

If you don't see the one you want, then add it with `@displayedunits`

```julia
import ThermofluidQuantities: 𝐋, 𝐓
@displayedunits MyInverseVelocityType "s/m" 𝐓/𝐋
```

Then you can create a quantity:

```julia
@dimvar MyInverseVelocityVar MyInverseVelocityType
MyInverseVelocityVar(2.3u"ft/min")
```

### Gases and liquids

There are several predefined properties for gases and liquids. You can see the lists here:

```julia
Thermofluids.gases
```

and

```julia
Thermofluids.liquids
```

For example, to see the properties of air,
```julia
Air
```

You can access any of the properties individually with, e.g.,
```julia
Viscosity(Air)
SpecificHeatRatio(Air)
```


