module RosettaOPFBenchmarks

using PowerModels
using ConcreteStructs
using LinearAlgebra
using Test

"""
    solve_opf(file_name::String, ::Val{PackageChoice})

Solve the ACOPF problem encoded in file `file_name` with the given `PackageChoice`, which must be a `Symbol` among the following options:

- `:ExaModels`
- `:JuMP`
- `:NLPModels`
- `:Nonconvex`
- `:Optim`
- `:Optimization`

Return a result encoded as a dictionary.

# Example

```julia
using RosettaOPFBenchmarks
import ADNLPModels, NLPModelsIpopt

solve_opf("data/opf_warmup.m", Val(:NLPModels))
```

# See also

- [`validate_result`](@ref)
"""
function solve_opf end

include("validator.jl")

export solve_opf
export validate_result

end # module RosettaOPFBenchmarks
