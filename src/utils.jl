# Macros for creating units and quantities
import Base:+,*,-,/,^,>,<,>=,<=,==,isapprox
import Base: exp, exp10, exp2, expm1, log, log10, log1p, log2
import Base: sin, cos, tan, asin, acos, atan, sinh, cosh, tanh, asinh, acosh, atanh,
             sinpi, cospi, sinc, cosc, cis

import Unitful: 𝐋, 𝐌, 𝚯, 𝐓, unit, ustrip

export value, name, unit, ustrip, ushow
export default_unit
export PhysicalQuantity, DimensionalPhysicalQuantity, DimensionlessPhysicalQuantity
export @displayedunits, @dimvar, @nondimvar, @gas, @liquid, displayedunits

abstract type PhysicalQuantity{U} <: Number end

abstract type DimensionalPhysicalQuantity{U} <: PhysicalQuantity{U} end
abstract type DimensionlessPhysicalQuantity{U} <: PhysicalQuantity{U} end


"""
    unit(a::PhysicalQuantity)

Return the units of quantity `a`. Extends `unit` operation
in `Unitful`.
"""
unit(::PhysicalQuantity{U}) where U = unit(U)

"""
    value(a::PhysicalQuantity)

Return the numerical value (with units) of `a`
"""
value(s::PhysicalQuantity) = float(s.val)

value(s::Unitful.Quantity) = float(s)
value(s::Real) = float(s)


"""
    value(a::PhysicalQuantity,units::Unitful.Units)

Return the numerical value of `a`, converted to units `units`.
The form of `units` must be of `Unitful` form, e.g. `u"Pa"`
and must be dimensionally compatible with `a`
"""
value(s::PhysicalQuantity,units::Unitful.Units) = uconvert(units,value(s))


"""
    ustrip(a::PhysicalQuantity)

Return the numerical value of `a`, stripped
of its units.
"""
ustrip(s::PhysicalQuantity) = ustrip(value(s))

"""
    ustrip(a::PhysicalQuantity,units::Unitful.Units)

Return the numerical value of `a`, converted to units `units`, and stripped
of its units. The form of `units` must be of `Unitful` form, e.g. `u"Pa"`
and must be dimensionally compatible with `a`.
"""
ustrip(s::PhysicalQuantity,units::Unitful.Units) = ustrip(value(s,units))

"""
    name(a::PhysicalQuantity)

Return the name of `a`.
"""
name(s::PhysicalQuantity) = s.name

function Base.show(io::IO, m::MIME"text/plain", s::PhysicalQuantity{U}) where {U}
    print(io,"$(s.name) = $(float(s.val))")
end

####### OPERATIONS ON ALL TYPES #######
#=
Some notes on these
- We do not necessarily wish for an operation on a PhysicalQuantity
  to return the same type of PhysicalQuantity. For example, if
  we add Pressure and PressureDifference, we should let the user
  specify what the result should be (by wrapping it in a type explicitly).
- When carrying out an operation between a PhysicalQuantity and a Number
  or a PhysicalQuantity and a Unitful.Quantity, just let the Unitful
  rules catch dimensional inconsistencies and throw errors.
=#

for op in (:(+),:(-),:(>),:(<),:(>=),:(<=),:(==))
    @eval $op(s1::PhysicalQuantity{U1},s2::PhysicalQuantity{U2}) where {U1,U2} = $op(s1.val,s2.val)
    @eval $op(s1::PhysicalQuantity{U1},s2::U2) where {U1,U2<:Quantity} = $op(s1.val,s2)
    @eval $op(s1::U1,s2::PhysicalQuantity{U2}) where {U1<:Quantity,U2} = $op(s1,s2.val)
    @eval $op(s::PhysicalQuantity,C::Real) = $op(s.val,C)
    @eval $op(C::Real,s::PhysicalQuantity) = $op(C,s.val)
end

for op in (:(isapprox),)
    @eval $op(s1::PhysicalQuantity{U1},s2::PhysicalQuantity{U2};kwargs...) where {U1,U2} = $op(s1.val,s2.val;kwargs...)
    @eval $op(s1::PhysicalQuantity{U1},s2::U2;kwargs...) where {U1,U2<:Quantity} = $op(s1.val,s2;kwargs...)
    @eval $op(s1::U1,s2::PhysicalQuantity{U2};kwargs...) where {U1<:Quantity,U2} = $op(s1,s2.val;kwargs...)
    @eval $op(s::PhysicalQuantity,C::Real;kwargs...) = $op(s.val,C;kwargs...)
    @eval $op(C::Real,s::PhysicalQuantity;kwargs...) = $op(C,s.val;kwargs...)
end

for op in (:(*),:(/))
    @eval $op(s1::PhysicalQuantity,s2::PhysicalQuantity) = $op(s1.val,s2.val)
    @eval $op(s1::PhysicalQuantity,s2::U) where {U<:Quantity} = $op(s1.val,s2)
    @eval $op(s1::U,s2::PhysicalQuantity) where {U<:Quantity} = $op(s1,s2.val)
    @eval $op(s::PhysicalQuantity,C::Real) = $op(s.val,C)
    @eval $op(C::Real,s::PhysicalQuantity) = $op(C,s.val)
end

for op in (:(^),)
    @eval $op(s::PhysicalQuantity,C::Integer) = $op(s.val,C)
    @eval $op(s::PhysicalQuantity,C::Real) = $op(s.val,C)
end

for op in (:sin, :cos, :tan, :asin, :acos, :atan, :sinh, :cosh, :tanh, :asinh,
           :acosh, :atanh,:sinpi, :cospi, :sinc, :cosc, :cis)
    @eval ($op)(s::DimensionlessPhysicalQuantity) = ($op)(s.val)
end

for op in (:exp, :exp10, :exp2, :expm1, :log, :log10, :log1p, :log2)
    @eval ($op)(s::DimensionlessPhysicalQuantity) = ($op)(s.val)
end


function displayedunits() end
function ushow() end


"""
    @displayedunits name unit dims

Set the preferred units for displaying quantities and
create function `displayedunits` for returning these units and
`ushow` for converting quantities into these units. The new unit type
is specified with `name`, the default units with `unit`, and the
dimensions with `dims`. The latter use the `Unitful` dimension names, `𝐌`,
`𝐓`, `𝐋`, `𝚯`, in combinations

# Examples
```jldoctest myunit
julia> import ThermofluidQuantities: 𝐋, 𝐓

julia> @displayedunits MyVelocityType "m/s" 𝐋/𝐓

julia> MyVelocityType
Union{Unitful.Quantity{T,𝐋 𝐓⁻¹,U}, Unitful.Level{L,S,Unitful.Quantity{T,𝐋 𝐓⁻¹,U}} where S where L} where U where T
```
"""
macro displayedunits(qty,a,dims)
  utype = isdefined(Unitful, qty) ? getfield(Unitful,qty) : qty
  strqty = string(qty)
  esc(quote
      ThermofluidQuantities.Unitful.@derived_dimension($qty,$dims)

      ThermofluidQuantities.displayedunits(::Type{$utype}) = @u_str($a)

      ThermofluidQuantities. ushow(x::$utype) = uconvert(@u_str($a),x)

      push!(ThermofluidQuantities.unittypes,Symbol($strqty))

      export $qty

      nothing

      end)
end

"""
    @dimvar name utype

Define a dimensional variable type of the given name, with units of type `utype`.
The `utype` is of the form created with the @displayedunits macro. A list
of such types can be found in `ThermofluidQuantities.unittypes`.

# Examples
```jldoctest mydimvar
julia> import ThermofluidQuantities: 𝐓

julia> @displayedunits MyTimeType "s" 𝐓

julia> @dimvar MyTimeVar MyTimeType

julia> MyTimeVar(5)
MyTimeVar = 5.0 s
```
"""
macro dimvar(qty,utype)
  strqty = string(qty)
  esc(quote

          struct $qty{U<:$utype} <: DimensionalPhysicalQuantity{U}
            val :: U
            name :: String
          end

          @doc """
              $($strqty)(x::Real)

          Create an instance of a $($strqty) type dimensional physical quantity,
          with value equal to `x` and units $(displayedunits($utype)).
          """ $qty(x::Real) = $qty(x*displayedunits($utype),$strqty)

          @doc """
              $($strqty)(x::Unitful.Quantity)

          Create an instance of a $($strqty) type dimensional physical quantity,
          with unit-ed value equal to `x`. Converts to units $(displayedunits($utype)).
          """ $qty(x::U) where {U<:$utype} = $qty(ushow(x),$strqty)
          default_unit(::Type{$qty}) = displayedunits($utype)

          push!(ThermofluidQuantities.dimvartypes,$qty)

          export $qty


      end)
end

"""
    @nondimvar name

Define a non-dimensional variable type of the given name.

# Examples
```jldoctest mynondimvar
julia> @nondimvar MyNondimVar

julia> MyNondimVar(100)
MyNondimVar = 100.0
```
"""
macro nondimvar(qty)
  strqty = string(qty)
  esc(quote

          struct $qty{U<:Real} <: DimensionlessPhysicalQuantity{U}
            val :: U
            name :: String
          end

          @doc """
              $($strqty)(x::Real)

          Create an instance of a $($strqty) type non-dimensional physical quantity,
          with value equal to `x`.
          """ $qty(x::Real) = $qty(x,$strqty)

          @doc """
              $($strqty)(x::Unitful.Quantity)

          Create an instance of a $($strqty) type non-dimensional physical quantity,
          with unit-ed value equal to `x`.
          """
          $qty(x::ThermofluidQuantities.Unitful.Quantity{T,ThermofluidQuantities.Unitful.NoDims}) where {T} = $qty(uconvert.(Unitful.NoUnits,x))

          push!(ThermofluidQuantities.nondimvartypes,$qty)

          export $qty

      end)
end

"""
    @liquid name temp dens visc surftens pv Ev

Create a liquid of the specified name, with viscosity `visc`, surface tension `surftens`,
vapor pressure `pv`, and bulk modulus `Ev` at reference temperature `temp`. Each of these must
be provided with units if they are not the default.

# Example
```jldoctest myliq
julia> @liquid MyWater 15u"°C" 999 1.13e-3 7.34e-2 1.77e3 2.15e9

julia> MyWater
Liquid with
   Density = 999.0 kg m⁻³
   Viscosity = 0.00113 kg m⁻¹ s⁻¹
   Kinematic viscosity = 1.131131131131131e-6 m² s⁻¹
   Specific weight = 9796.84335 N m⁻³
   Surface tension = 0.0734 N m⁻¹
   Bulk modulus = 2.15e9 Pa
   Vapor pressure = 1770.0 Pa
   at reference temp 288.15 K
```
"""
macro liquid(name,temp,density,viscosity,surftens,pv,Ev)
    strname = string(name)
    esc(quote
            const $name = Liquid(Tref = Temperature($temp),
                                 ρref = Density($density),
                                 μ = Viscosity($viscosity),
                                 σ = SurfaceTension($surftens),
                                 pv = VaporPressure($pv),
                                 Ev = BulkModulus($Ev))
            export $name

            push!(ThermofluidQuantities.liquids,Symbol($strname))

            nothing
        end)
end

"""
    @gas name temp visc gamma mmass

Create a gas of the specified name, with viscosity `visc` and ratio of specific heats
`gamma` at reference temperature `temp`, and molar mass `mmass`. Each of these must
be provided with units if they are not the default.

# Example
```jldoctest mygas
julia> @gas MyO2 20u"°C" 2.04e-5 1.395 31.999u"g/mol"

julia> MyO2
Perfect gas with
   Density = 1.330236729981785 kg m⁻³
   Viscosity = 2.04e-5 kg m⁻¹ s⁻¹
   Specific heat ratio = 1.395
   Gas constant = 259.83507666343445 J kg⁻¹ K⁻¹
   cp = 917.645397330357 J kg⁻¹ K⁻¹
   cv = 657.8103206669226 J kg⁻¹ K⁻¹
   at reference temp 293.15 K
```
"""
macro gas(name,temp,viscosity,gamma,molarmass)
    strname = string(name)
    esc(quote
            const $name = PerfectGas(Tref = Temperature($temp),
                                     μ = Viscosity($viscosity),
                                     γ = SpecificHeatRatio($gamma),
                                     R = GasConstant(ThermofluidQuantities.Unitful.R/$molarmass))
            export $name

            push!(ThermofluidQuantities.gases,Symbol($strname))

            nothing
        end)
end
