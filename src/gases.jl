######## GAS DEFINITIONS #######

export AbstractGas, PerfectGas

abstract type AbstractGas <: AbstractFluid end

# default values
const DefaultGasRefTemperature = Temperature(15u"°C")
const DefaultGasRefPressure = Pressure(1u"atm")
const DefaultGasConstant = GasConstant(287)
const DefaultSpecificHeatRatio = SpecificHeatRatio(1.4)
const DefaultGasViscosity = Viscosity(1.79e-5)

SpecificHeatPressure(;γ::SpecificHeatRatio=DefaultSpecificHeatRatio,
                      R::GasConstant=DefaultGasConstant) = SpecificHeatPressure(γ*R/(γ-1))
SpecificHeatVolume(;γ::SpecificHeatRatio=DefaultSpecificHeatRatio,
                    R::GasConstant=DefaultGasConstant) = SpecificHeatVolume(R/(γ-1))



struct PerfectGas <: AbstractGas
    Tref :: Temperature
    pref :: Pressure
    ρref :: Density
    specwt :: SpecificWeight
    μ :: Viscosity
    ν :: KinematicViscosity
    γ :: SpecificHeatRatio
    R :: GasConstant
    cp :: SpecificHeatPressure
    cv :: SpecificHeatVolume
end

function PerfectGas(;
            Tref::Temperature=DefaultGasRefTemperature,
            pref::Pressure=DefaultGasRefPressure,
            μ::Viscosity=DefaultGasViscosity,
            γ::SpecificHeatRatio=DefaultSpecificHeatRatio,
            R::GasConstant=DefaultGasConstant)

    ρref = Density(pref/Tref/R)
    return PerfectGas(Tref,pref,ρref,SpecificWeight(ρref*1u"ge"),μ,KinematicViscosity(μ/ρref),γ,R,SpecificHeatPressure(γ=γ,R=R),SpecificHeatVolume(γ=γ,R=R))
end

Density(g::PerfectGas) = g.ρref
Viscosity(g::PerfectGas) = g.μ
KinematicViscosity(g::PerfectGas) = g.ν
SpecificWeight(g::PerfectGas) = g.specwt
SpecificHeatRatio(g::PerfectGas) = g.γ
GasConstant(g::PerfectGas) = g.R
SpecificHeatPressure(g::PerfectGas) = g.cp
SpecificHeatVolume(g::PerfectGas) = g.cv

function Base.show(io::IO, m::MIME"text/plain", g::PerfectGas)
    println(io,"Perfect gas with")
    println(io,"   Density = $(value(Density(g)))")
    println(io,"   Viscosity = $(value(Viscosity(g)))")
    println(io,"   Specific heat ratio = $(value(SpecificHeatRatio(g)))")
    println(io,"   Gas constant = $(value(GasConstant(g)))")
    println(io,"   cp = $(value(SpecificHeatPressure(g)))")
    println(io,"   cv = $(value(SpecificHeatVolume(g)))")
    println(io,"   at reference temp $(value(g.Tref))")
end
