@testset "Friction factor" begin

  @test_throws DomainError FrictionFactor(ReynoldsNumber(-10),RoughnessRatio(0.001))

  @test_throws DomainError FrictionFactor(ReynoldsNumber(10),RoughnessRatio(-0.001))

  @test FrictionFactor(ReynoldsNumber(1e5),RoughnessRatio(0.002)) < 0.035

end
