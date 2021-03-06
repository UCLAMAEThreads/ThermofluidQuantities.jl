using ThermofluidQuantities
using Test
using Literate

const GROUP = get(ENV, "GROUP", "All")

#ENV["GKSwstype"] = "nul" # removes GKS warnings during plotting
ENV["GKSwstype"] = "100"

notebookdir = "../notebook"
docdir = "../docs/src/manual"
litdir = "./literate"

if GROUP == "All" || GROUP == "Basics"
    include("macros.jl")
    include("frictionfactor.jl")
end

if GROUP == "All" || GROUP == "Notebooks"
  for (root, dirs, files) in walkdir(litdir)
    for file in files
      endswith(file,".jl") && Literate.notebook(joinpath(root, file),notebookdir)
    end
  end
end

if GROUP == "Documentation"
  for (root, dirs, files) in walkdir(litdir)
    for file in files
      endswith(file,".jl") && Literate.markdown(joinpath(root, file),docdir)
    end
  end
end
