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

@testset verbose=true "Rosetta OPF" begin
    @testset "$framework" for framework in [
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
            "pglib_opf_case24_ieee_rts.m",
        ]
            @info "Testing" framework case
            test_case = joinpath(dirname(@__DIR__), "data", case)
            result = solve_opf(test_case, Val(framework))
            if framework == :Optim  # does not converge to feasible solution
                @test_skip validate_result(test_case, result)
            else
                validate_result(test_case, result)
            end
        end
    end
end
