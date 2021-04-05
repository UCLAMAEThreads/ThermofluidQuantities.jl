const gases = Vector{Symbol}()

const DefaultPerfectGas = PerfectGas()
const Air = PerfectGas()
export DefaultPerfectGas, Air
push!(gases,:Air)

# To add a gas, give it a name, the specific heat ratio, and the molar mass
@gas He  20u"°C"   1.94e-5   5//3    4.002602u"g/mol"
@gas O2  20u"°C"   2.04e-5   1.395   31.999u"g/mol"
@gas CO2 20u"°C"   1.47e-5   1.289   44.01u"g/mol"
@gas H2  20u"°C"   8.84e-6   1.405   2.016u"g/mol"
@gas Methane 20u"°C" 1.10e-5 1.299   16.043u"g/mol"
@gas N2  20u"°C"   1.76e-5   1.40    28.0134u"g/mol"
