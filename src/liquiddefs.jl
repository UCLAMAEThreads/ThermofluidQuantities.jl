const liquids = Vector{Symbol}()

const DefaultLiquid = Liquid()
const Water = Liquid()
export Water
push!(liquids,:Water)

@liquid Seawater 15.6u"°C" 1030 1.20e-3  7.34e-2 1.77e3  2.34e9
@liquid Glycerin 20u"°C" 1260  1.50e0  6.33e-2 1.4e-2 4.52e9
@liquid Gasoline 15.6u"°C" 680  3.1e-4 2.2e-2  5.5e4 1.3e9
