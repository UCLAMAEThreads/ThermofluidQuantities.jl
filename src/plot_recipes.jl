using RecipesBase
#import PlotUtils: cgrad, palette, color_list
using UnitfulRecipes


@recipe function f(x::AbstractArray{S},y::AbstractArray{T}) where {S <: PhysicalQuantity, T <: PhysicalQuantity}
    value.(x), value.(y)
end
@recipe function f(x::AbstractArray{S},y::AbstractArray{T}) where {S <: PhysicalQuantity, T}
    value.(x), y
end
@recipe function f(x::AbstractArray{S},y::AbstractArray{T}) where {S, T <: PhysicalQuantity}
    x, value.(y)
end
