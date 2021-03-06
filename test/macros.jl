import ThermofluidQuantities: Unitful, ð, ð, ð

@testset "Define unit types" begin

  @displayedunits MyVelocityType "m/s" ð/ð
  @test MyVelocityType == Union{Unitful.Quantity{T,ð*ð^-1,U}, Unitful.Level{L,S,Unitful.Quantity{T,ð*ð^-1,U}} where S where L} where U where T

  @dimvar MyVelocityVar MyVelocityType

  @test value(MyVelocityVar(5)) == 5.0u"m/s"

  v = MyVelocityVar(10) + Velocity(20)
  @test value(v) == 30.0u"m/s"

  @nondimvar MyNondimVar

  @test value(MyNondimVar(10)) == 10.0

  @test_throws Unitful.DimensionError MyVelocityVar(10) + MyNondimVar(5)


end

@testset "Operations" begin

  p1 = Pressure(5u"Pa")
  p2 = Pressure(20)

  @test p1 + p2 == 25u"Pa"
  @test value(Pressure(p1+p2)) == 25u"Pa"
  @test ustrip(Pressure(p1+p2)) == 25.0

  mĖ = MassFlowRate(5)
  @test value(mĖ) == 5u"kg/s"
  @test 2*mĖ == 10u"kg/s"
  @test mĖ*2 == 10u"kg/s"
  @test mĖ/2 == 2.5u"kg/s"
  @test 2/mĖ == 0.4u"s/kg"
  @test mĖ^3 == 125u"kg^3/s^3"

  @test TemperatureRatio(4.0)^(1//2) == 2.0

  @test Length(50) > Length(40) > Diameter(5)
  @test_throws Unitful.DimensionError Length(40) > Area(30)

  @test sinh(ReynoldsNumber(5)) == sinh(5)
  @test log(ReynoldsNumber(5)) == log(Velocity(5)*Length(4)/KinematicViscosity(4))

  @test_throws MethodError sin(Velocity(5))




end
