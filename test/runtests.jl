ENV["DATADEPS_ALWAYS_ACCEPT"] = true

using Test
using RosettaOPFBenchmarks

# dependencies
using ADNLPModels
using ExaModels
using ForwardDiff
using Ipopt
using JuMP
using ModelingToolkit
using NLPModelsIpopt
using Nonconvex
using NonconvexIpopt
using Optim
using Optimization
using OptimizationMOI

@testset verbose = true "Rosetta OPF" begin
    @testset verbose=true "$framework" for framework in [
        :ExaModels,
        :JuMP,
        :NLPModels,
        :Nonconvex,
        :Optim,
        :Optimization,
    ]
        @testset "$case" for case in [
            "opf_warmup.m",
            "pglib_opf_case5_pjm.m",
            "pglib_opf_case14_ieee.m",
            # "pglib_opf_case24_ieee_rts.m",
        ]
            yield()
            @info "Testing" framework case
            if occursin("warmup", case)
                path = joinpath(dirname(@__DIR__), "data", case)
            else
                path = read_instance(case)
            end
            result = solve_opf(path, Val(framework))
            if framework == :Optim  # does not converge to feasible solution
                @test_skip validate_result(path, result)
            else
                validate_result(path, result)
            end
        end
    end
end;
