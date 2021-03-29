######## GAS DEFINITIONS #######

export AbstractGas, PerfectGas

abstract type AbstractGas end

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


const DefaultPerfectGas = PerfectGas()
const Air = PerfectGas()
export Air

# To add a gas, give it a name, the specific heat ratio, and the molar mass
@create_gas He  20u"°C"   1.94e-5   5//3    4.002602u"g/mol"
@create_gas O2  20u"°C"   2.04e-5   1.395   31.999u"g/mol"
@create_gas CO2 20u"°C"   1.47e-5   1.289   44.01u"g/mol"
@create_gas H2  20u"°C"   8.84e-6   1.405   2.016u"g/mol"
@create_gas Methane 20u"°C" 1.10e-5 1.299   16.043u"g/mol"
@create_gas N2  20u"°C"   1.76e-5   1.40    28.0134u"g/mol"
