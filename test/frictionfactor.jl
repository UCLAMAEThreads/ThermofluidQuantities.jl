@testset "Friction factor" begin

  @test_throws DomainError FrictionFactor(ReynoldsNumber(-10),RoughnessRatio(0.001))

  @test_throws DomainError FrictionFactor(ReynoldsNumber(10),RoughnessRatio(-0.001))


end
