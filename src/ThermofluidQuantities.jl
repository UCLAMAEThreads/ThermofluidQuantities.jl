module ThermofluidQuantities

import Base:+,*,-,/,^,>,<,>=,<=,==,isapprox
import Base: exp, exp10, exp2, expm1, log, log10, log1p, log2
import Base: sin, cos, tan, asin, acos, atan, sinh, cosh, tanh, asinh, acosh, atanh,
             sinpi, cospi, sinc, cosc, cis

  # This form is necessary to add new units
  import Unitful
  using Unitful: @unit, @u_str, Quantity, @derived_dimension, uconvert
  import Unitful: unit, ustrip
  #import Unitful: 𝐋, 𝐌, 𝚯, 𝐓, unit, ustrip
  using Unitful.DefaultSymbols

  export @u_str
  export value, name, unit, ustrip, ushow, uconvert
  export default_unit
  export PhysicalQuantity, DimensionalPhysicalQuantity, DimensionlessPhysicalQuantity
  export AbstractFluid
  export @displayedunits, @dimvar, @nondimvar, @gas, @liquid, displayedunits

  abstract type AbstractFluid end

  const dimvartypes = Vector{Type}()
  const nondimvartypes = Vector{Type}()
  const unittypes = Vector{Symbol}()


  include("units.jl")
  include("utils.jl")
  include("quantities.jl")
  include("gases.jl")
  include("liquids.jl")
  include("gasdefs.jl")
  include("liquiddefs.jl")

  include("plot_recipes.jl")


  const localunits = Unitful.basefactors

  function __init__()

    merge!(Unitful.basefactors, localunits)
    Unitful.register(ThermofluidQuantities)

  end


end # module
