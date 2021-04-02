module ThermofluidQuantities


  # This form is necessary to add new units
  import Unitful
  using Unitful: @unit, @u_str, Quantity, @derived_dimension, uconvert
  export @u_str

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
