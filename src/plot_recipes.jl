using RecipesBase
using ColorTypes
import PlotUtils: cgrad, palette, color_list
using UnitfulRecipes


@recipe function f(x::AbstractArray{S},y::AbstractArray{T}) where {S <: FlowQuantity, T <: FlowQuantity}
    value.(x), value.(y)
end
@recipe function f(x::AbstractArray{S},y::AbstractArray{T}) where {S <: FlowQuantity, T}
    value.(x), y
end
@recipe function f(x::AbstractArray{S},y::AbstractArray{T}) where {S, T <: FlowQuantity}
    x, value.(y)
end
