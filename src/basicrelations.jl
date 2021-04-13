#=
Geometric relationships
=#
"""
    Area(d::Diameter)

Return the area of a circle with diameter `d`.
"""
Area(D::Diameter) = Area(π*D^2/4)

"""
    Diameter(A::Area)

Return the diameter of a circle with area `A`.
"""
Diameter(A::Area) = Diameter(sqrt(4*A/π))

# Earth's gravity
"""
    Gravity()

Get Earth's gravity.
"""
Gravity() = Gravity(1u"ge")

"""
    SpecificWeight(sg::SpecificGravity)

Return the specific weight of a material with specific gravity `sg`.
"""
SpecificWeight(sg::SpecificGravity) = SpecificWeight(sg*SpecificWeight(Water))
