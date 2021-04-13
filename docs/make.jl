using Documenter, ThermofluidQuantities

makedocs(
    sitename = "ThermofluidQuantities.jl",
    doctest = true,
    clean = true,
    pages = [
        "Home" => "index.md",
        "Manual" => ["manual/0-UnitsAndQuantities.md",
                     "manual/1-VelocityProfiles.md",
                     "manual/functions.md"
                     ]
        #"Internals" => [ "internals/properties.md"]
    ],
    #format = Documenter.HTML(assets = ["assets/custom.css"])
    format = Documenter.HTML(
        prettyurls = get(ENV, "CI", nothing) == "true",
        mathengine = MathJax(Dict(
            :TeX => Dict(
                :equationNumbers => Dict(:autoNumber => "AMS"),
                :Macros => Dict()
            )
        ))
    ),
    #assets = ["assets/custom.css"],
    #strict = true
)


#if "DOCUMENTER_KEY" in keys(ENV)
deploydocs(
     repo = "github.com/UCLAMAEThreads/ThermofluidQuantities.jl.git",
     target = "build",
     devbranch = "main",
     deps = nothing,
     make = nothing
     #versions = "v^"
)
#end
