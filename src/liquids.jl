######## GAS DEFINITIONS #######

export AbstractLiquid, Liquid

abstract type AbstractLiquid <: AbstractFluid end


# default values
const DefaultLiquidRefTemperature = Temperature(15.6u"°C")
const DefaultLiquidRefDensity = Density(999)
const DefaultLiquidViscosity = Viscosity(1.12e-3)
const DefaultSurfaceTension = SurfaceTension(7.34e-2)
const DefaultVaporPressure = VaporPressure(1.77e3)
const DefaultBulkModulus = BulkModulus(2.15e9)


struct Liquid <: AbstractLiquid
    Tref :: Temperature
    ρref :: Density
    specwt :: SpecificWeight
    μ :: Viscosity
    ν :: KinematicViscosity
    σ :: SurfaceTension
    pv :: VaporPressure
    Ev :: BulkModulus
end

function Liquid(;
            Tref::Temperature = DefaultLiquidRefTemperature,
            ρref::Density = DefaultLiquidRefDensity,
            μ::Viscosity = DefaultLiquidViscosity,
            σ::SurfaceTension = DefaultSurfaceTension,
            pv::VaporPressure = DefaultVaporPressure,
            Ev::BulkModulus = DefaultBulkModulus
            )

    return Liquid(Tref,ρref,SpecificWeight(ρref*1u"ge"),μ,KinematicViscosity(μ/ρref),σ,pv,Ev)
end

Density(g::Liquid) = g.ρref
Viscosity(g::Liquid) = g.μ
KinematicViscosity(g::Liquid) = g.ν
SpecificWeight(g::Liquid) = g.specwt
SurfaceTension(g::Liquid) = g.σ
VaporPressure(g::Liquid) = g.pv
BulkModulus(g::Liquid) = g.Ev

function Base.show(io::IO, m::MIME"text/plain", g::Liquid)
    println(io,"Liquid with")
    println(io,"   Density = $(value(Density(g)))")
    println(io,"   Viscosity = $(value(Viscosity(g)))")
    println(io,"   Kinematic viscosity = $(value(KinematicViscosity(g)))")
    println(io,"   Specific weight = $(value(SpecificWeight(g)))")
    println(io,"   Surface tension = $(value(SurfaceTension(g)))")
    println(io,"   Bulk modulus = $(value(BulkModulus(g)))")
    println(io,"   Vapor pressure = $(value(VaporPressure(g)))")
    println(io,"   at reference temp $(value(g.Tref))")
end
