module RosettaOPFBenchmarks

using DataDeps
using PowerModels
using ConcreteStructs
using LinearAlgebra
using Test

include("read.jl")
include("solve.jl")
include("validate.jl")

export read_instance
export solve_opf
export validate_result

function __init__()
    DataDeps.register(
        DataDep(
            "pglib-opf",
            """
            Benchmarks for the Optimal Power Flow Problem.

            URL: <https://github.com/power-grid-lib/pglib-opf>
            
            Maintainers: IEEE PES Task Force on Benchmarks for Validation of Emerging Power System Algorithms (<https://power-grid-lib.github.io/>).
            """,
            # modify link below to update version of `pglib-opf`
            "https://github.com/power-grid-lib/pglib-opf/archive/refs/tags/v23.07.tar.gz";
            post_fetch_method=DataDeps.unpack
        ),
    )
end

end # module RosettaOPFBenchmarks
