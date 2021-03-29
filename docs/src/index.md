# ThermofluidQuantities.jl

*basic tools and definitions of quantities in thermofluids problems*

The purpose of this package is to enable easy setup of quantities in thermofluids problems. It contains
- A large set of specialized types based on common thermofluid quantities
  (e.g. `Velocity`, `Pressure`, etc) that enable dispatch on these
  quantities
- Treatment of typical units, using the [Unitful](https://github.com/PainterQubits/Unitful.jl) package.
- Predefined properties for various common gases and liquids
- Plot recipes for the associated types

## Installation

This package works on Julia `1.0` and higher and is registered in the general Julia registry. To install, type
```julia
]add ThermofluidQuantities
```

Then type
```julia
julia> using ThermofluidQuantities
```

The plots in this documentation are generated using [Plots.jl](http://docs.juliaplots.org/latest/).
You might want to install that, too, to follow the examples.
