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
