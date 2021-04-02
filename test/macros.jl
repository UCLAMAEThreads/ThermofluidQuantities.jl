import ThermofluidQuantities: Unitful, 𝐋, 𝐌, 𝐓

@testset "Define unit types" begin

  @displayedunits MyVelocityType "m/s" 𝐋/𝐓
  @test MyVelocityType == Union{Unitful.Quantity{T,𝐋*𝐓^-1,U}, Unitful.Level{L,S,Unitful.Quantity{T,𝐋*𝐓^-1,U}} where S where L} where U where T

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

  ṁ = MassFlowRate(5)
  @test value(ṁ) == 5u"kg/s"
  @test 2*ṁ == 10u"kg/s"
  @test ṁ*2 == 10u"kg/s"
  @test ṁ/2 == 2.5u"kg/s"
  @test 2/ṁ == 0.4u"s/kg"
  @test ṁ^3 == 125u"kg^3/s^3"

  @test Length(50) > Length(40) > Diameter(5)
  @test_throws Unitful.DimensionError Length(40) > Area(30)

  @test sinh(ReynoldsNumber(5)) == sinh(5)
  @test log(ReynoldsNumber(5)) == log(Velocity(5)*Length(4)/KinematicViscosity(4))

  @test_throws MethodError sin(Velocity(5))




end
