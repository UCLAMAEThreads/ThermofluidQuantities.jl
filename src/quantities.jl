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
@displayedunits AccelerationType   "m/s^2"    𝐋/𝐓^2
@displayedunits AngularVelocityType "rad/s" 𝐓^-1
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
@dimvar SpecificHeatPressure   SpecificHeatType
@dimvar SpecificHeatVolume     SpecificHeatType
@dimvar GasConstant            SpecificHeatType
@dimvar Viscosity              ViscosityType
@dimvar KinematicViscosity     KinematicViscosityType
@dimvar SurfaceTension         ForcePerLengthType
@dimvar SpecificWeight         SpecificWeightType
@dimvar VaporPressure          PressureType
@dimvar BulkModulus            PressureType

@nondimvar SpecificHeatRatio
@nondimvar SpecificGravity


# Dimensional variables
@dimvar Pressure               PressureType
@dimvar PressureDifference     PressureType
@dimvar GaugePressure          PressureType
@dimvar StagnationPressure     PressureType
@dimvar Density                DensityType
@dimvar StagnationDensity      DensityType
@dimvar Temperature            TemperatureType
@dimvar StagnationTemperature  TemperatureType
@dimvar InternalEnergy         SpecificEnergyType
@dimvar StagnationInternalEnergy SpecificEnergyType
@dimvar Enthalpy               SpecificEnergyType
@dimvar StagnationEnthalpy     SpecificEnergyType
@dimvar SoundSpeed             VelocityType
@dimvar StagnationSoundSpeed   VelocityType
@dimvar Velocity               VelocityType
@dimvar UVelocity              VelocityType
@dimvar VVelocity              VelocityType
@dimvar WVelocity              VelocityType
@dimvar AngularVelocity        AngularVelocityType
@dimvar Acceleration           AccelerationType
@dimvar Gravity                AccelerationType
@dimvar Entropy                SpecificHeatType
@dimvar MassFlowRate           MassFlowRateType
@dimvar HeatFlux               SpecificEnergyType
@dimvar VolumeFlowRate         FlowRateType
@dimvar Force                  ForceType
@dimvar ForcePerDepth          ForcePerLengthType
@dimvar Time                   TimeType
@dimvar Head                   LengthType


@dimvar Area                   AreaType
@dimvar Diameter               LengthType
@dimvar Length                 LengthType
@dimvar Volume                 VolumeType


# Non-dimensional variables
@nondimvar MachNumber
@nondimvar ReynoldsNumber
@nondimvar DragCoefficient
@nondimvar LiftCoefficient
@nondimvar PressureCoefficient
@nondimvar FrictionFactor

# a generic catchall
@nondimvar DimensionlessParameter

@nondimvar FLOverD
@nondimvar PressureRatio
@nondimvar StagnationPressureRatio
@nondimvar TemperatureRatio
@nondimvar DensityRatio
@nondimvar VelocityRatio
@nondimvar AreaRatio


#=
Geometric relationships
=#
Area(D::Diameter) = Area(π*D^2/4)
Diameter(A::Area) = Diameter(sqrt(4*A/π))

# Earth's gravity
Gravity() = Gravity(1u"ge")
