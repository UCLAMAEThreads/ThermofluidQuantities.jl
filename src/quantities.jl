######## SET UNIT CLASSES #######
#=
Here, we set classes of unit names for the quantities to be defined later.
The second argument is the preferred units in which to display the quantity.
The third argument is the dimension of the quantity.
=#
@displayedunits TimeType           "s"      𝐓
@displayedunits TemperatureType    "K"      𝚯
@displayedunits MassType           "kg"     𝐌
@displayedunits LengthType         "m"      𝐋
@displayedunits PressureType       "Pa"     𝐌/𝐓^2/𝐋
@displayedunits DensityType        "kg/m^3" 𝐌/𝐋^3
@displayedunits SpecificEnergyType "J/kg"   𝐋^2/𝐓^2
@displayedunits SpecificHeatType   "J/kg/K" 𝐋^2/𝐓^2/𝚯
@displayedunits VelocityType       "m/s"    𝐋/𝐓
@displayedunits AreaType           "m^2"    𝐋^2
@displayedunits VolumeType         "m^3"    𝐋^3
@displayedunits MassFlowRateType   "kg/s"   𝐌/𝐓
@displayedunits FlowRateType       "m^3/s"  𝐋^3/𝐓
@displayedunits KinematicViscosityType "m^2/s" 𝐋^2/𝐓
@displayedunits ViscosityType      "kg/m/s" 𝐌/𝐓/𝐋
@displayedunits ForcePerLengthType "N/m"    𝐌/𝐓^2
@displayedunits ForceType          "N"      𝐌*𝐋/𝐓^2
@displayedunits SpecificWeightType "N/m^3"  𝐌/𝐋^2/𝐓^2


#=
Quantities and properties

Note: to add a new quantity, you define it here, assigning the units from
the list above of QtyType
=#
@create_dimvar SpecificHeatPressure   SpecificHeatType
@create_dimvar SpecificHeatVolume     SpecificHeatType
@create_dimvar GasConstant            SpecificHeatType
@create_dimvar Viscosity              ViscosityType
@create_dimvar KinematicViscosity     KinematicViscosityType
@create_dimvar SurfaceTension         ForcePerLengthType
@create_dimvar SpecificWeight         SpecificWeightType
@create_dimvar VaporPressure          PressureType
@create_dimvar BulkModulus            PressureType

@create_nondimvar SpecificHeatRatio
@create_nondimvar SpecificGravity


# Dimensional variables
@create_dimvar Pressure               PressureType
@create_dimvar PressureDifference     PressureType
@create_dimvar GaugePressure          PressureType
@create_dimvar StagnationPressure     PressureType
@create_dimvar Density                DensityType
@create_dimvar StagnationDensity      DensityType
@create_dimvar Temperature            TemperatureType
@create_dimvar StagnationTemperature  TemperatureType
@create_dimvar InternalEnergy         SpecificEnergyType
@create_dimvar StagnationInternalEnergy SpecificEnergyType
@create_dimvar Enthalpy               SpecificEnergyType
@create_dimvar StagnationEnthalpy     SpecificEnergyType
@create_dimvar SoundSpeed             VelocityType
@create_dimvar StagnationSoundSpeed   VelocityType
@create_dimvar Velocity               VelocityType
@create_dimvar Entropy                SpecificHeatType
@create_dimvar MassFlowRate           MassFlowRateType
@create_dimvar HeatFlux               SpecificEnergyType
@create_dimvar VolumeFlowRate         FlowRateType
@create_dimvar Force                  ForceType
@create_dimvar ForcePerDepth          ForcePerLengthType
@create_dimvar Time                   TimeType


@create_dimvar Area                   AreaType
@create_dimvar Diameter               LengthType
@create_dimvar Length                 LengthType
@create_dimvar Volume                 VolumeType


# Non-dimensional variables
@create_nondimvar MachNumber
@create_nondimvar ReynoldsNumber
@create_nondimvar DragCoefficient
@create_nondimvar LiftCoefficient
@create_nondimvar PressureCoefficient
@create_nondimvar FrictionFactor


@create_nondimvar FLOverD
@create_nondimvar PressureRatio
@create_nondimvar StagnationPressureRatio
@create_nondimvar TemperatureRatio
@create_nondimvar DensityRatio
@create_nondimvar VelocityRatio
@create_nondimvar AreaRatio


#=
Geometric relationships
=#
Area(D::Diameter) = Area(π*D^2/4)
Diameter(A::Area) = Diameter(sqrt(4*A/π))
