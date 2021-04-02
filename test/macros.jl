@testset "Define unit types" begin

  import ThermofluidQuantities: Unitful, 𝐋, 𝐌, 𝐓
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
