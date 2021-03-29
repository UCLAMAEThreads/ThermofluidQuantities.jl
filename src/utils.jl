# Macros for creating units and quantities
import Base:+,*,-,/,^,>,<,>=,<=,==,isapprox
import Unitful: 𝐋, 𝐌, 𝚯, 𝐓, unit, ustrip

export value, name
export default_unit


abstract type FlowQuantity{U} end

"""
    unit(a::FlowQuantity)

Return the units of quantity `a`. Extends `unit` operation
in `Unitful`.
"""
unit(::FlowQuantity{U}) where U = unit(U)

"""
    value(a::FlowQuantity)

Return the numerical value (with units) of `a`
"""
value(s::FlowQuantity) = float(s.val)

value(s::Unitful.Quantity) = float(s)
value(s::Real) = float(s)


"""
    value(a::FlowQuantity,units::Unitful.Units)

Return the numerical value of `a`, converted to units `units`.
The form of `units` must be of `Unitful` form, e.g. `u"Pa"`
and must be dimensionally compatible with `a`
"""
value(s::FlowQuantity,units::Unitful.Units) = uconvert(units,value(s))


"""
    ustrip(a::FlowQuantity)

Return the numerical value of `a`, stripped
of its units.
"""
ustrip(s::FlowQuantity) = ustrip(value(s))

"""
    ustrip(a::FlowQuantity,units::Unitful.Units)

Return the numerical value of `a`, converted to units `units`, and stripped
of its units. The form of `units` must be of `Unitful` form, e.g. `u"Pa"`
and must be dimensionally compatible with `a`.
"""
ustrip(s::FlowQuantity,units::Unitful.Units) = ustrip(value(s,units))

"""
    name(a::FlowQuantity)

Return the name of `a`.
"""
name(s::FlowQuantity) = s.name

function Base.show(io::IO, m::MIME"text/plain", s::FlowQuantity{U}) where {U}
    print(io,"$(s.name) = $(float(s.val))")
end

####### OPERATIONS ON ALL TYPES #######

for op in (:(+),:(-),:(>),:(<),:(>=),:(<=),:(==))
    @eval $op(s1::FlowQuantity{U1},s2::FlowQuantity{U2}) where {U1,U2} = $op(s1.val,s2.val)
    @eval $op(s1::FlowQuantity{U1},s2::U2) where {U1,U2<:Quantity} = $op(s1.val,s2)
    @eval $op(s1::U1,s2::FlowQuantity{U2}) where {U1<:Quantity,U2} = $op(s1,s2.val)
    @eval $op(s::FlowQuantity,C::Real) = $op(s.val,C)
    @eval $op(C::Real,s::FlowQuantity) = $op(C,s.val)
end

for op in (:(isapprox),)
    @eval $op(s1::FlowQuantity{U1},s2::FlowQuantity{U2};kwargs...) where {U1,U2} = $op(s1.val,s2.val;kwargs...)
    @eval $op(s1::FlowQuantity{U1},s2::U2;kwargs...) where {U1,U2<:Quantity} = $op(s1.val,s2;kwargs...)
    @eval $op(s1::U1,s2::FlowQuantity{U2};kwargs...) where {U1<:Quantity,U2} = $op(s1,s2.val;kwargs...)
    @eval $op(s::FlowQuantity,C::Real;kwargs...) = $op(s.val,C;kwargs...)
    @eval $op(C::Real,s::FlowQuantity;kwargs...) = $op(C,s.val;kwargs...)
end

for op in (:(*),:(/))
    @eval $op(s1::FlowQuantity,s2::FlowQuantity) = $op(s1.val,s2.val)
    @eval $op(s1::FlowQuantity,s2::U) where {U<:Quantity} = $op(s1.val,s2)
    @eval $op(s1::U,s2::FlowQuantity) where {U<:Quantity} = $op(s1,s2.val)
    @eval $op(s::FlowQuantity,C::Real) = $op(s.val,C)
    @eval $op(C::Real,s::FlowQuantity) = $op(C,s.val)
end

for op in (:(^),)
    @eval $op(s::FlowQuantity,C::Real) = $op(s.val,C)
end



"""
    @displayedunits(qty,a)

Set the preferred units for displaying quantities and
create function `displayedunits` for returning these units and
`ushow` for converting quantities into these units.
"""
macro displayedunits(qty,a,dims)
  utype = isdefined(Unitful, qty) ? getfield(Unitful,qty) : qty
  esc(quote
      @derived_dimension($qty,$dims)

      displayedunits(::Type{$utype}) = @u_str($a)

      ushow(x::$utype) = uconvert(@u_str($a),x)

      end)
end

macro create_dimvar(qty,utype)
  strqty = string(qty)
  esc(quote
          export $qty

          struct $qty{U<:$utype} <: FlowQuantity{U}
            val :: U
            name :: String
          end
          $qty(x::U) where {U<:$utype} = $qty(ushow(x),$strqty)
          $qty(x::Real) = $qty(x*displayedunits($utype),$strqty)
          default_unit(::Type{$qty}) = displayedunits($utype)

      end)
end

macro create_nondimvar(qty)
  strqty = string(qty)
  esc(quote
          struct $qty{U<:Real} <: FlowQuantity{U}
            val :: U
            name :: String
          end
          $qty(x::Real) = $qty(x,$strqty)

          export $qty
      end)
end

macro create_liquid(name,temp,density,viscosity,surftens,pv,Ev)
    esc(quote
            const $name = Liquid(Tref = Temperature($temp),
                                 ρref = Density($density),
                                 μ = Viscosity($viscosity),
                                 σ = SurfaceTension($surftens),
                                 pv = VaporPressure($pv),
                                 Ev = BulkModulus($Ev))
            export $name
        end)
end

macro create_gas(name,temp,viscosity,gamma,molarmass)
    esc(quote
            const $name = PerfectGas(Tref = Temperature($temp),
                                     μ = Viscosity($viscosity),
                                     γ = SpecificHeatRatio($gamma),
                                     R = GasConstant(Unitful.R/$molarmass))
            export $name
        end)
end
