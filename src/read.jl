"""
    read_instance(filename::String; group=nothing)

Download an instance from the `pglib-opf` benchmark (<https://github.com/power-grid-lib/pglib-opf>) and return its absolute path on the current machine.

To download non-default instances, `group` can be set to:
- `:api` for heavily loaded test cases
- `:sad` for test cases with small phase angle differences

!!! note
    The version of `pglib-opf` used here is v23.07.
"""
function read_instance(filename::String; group=nothing)
    @assert group in (nothing, :sad, :api)
    if isnothing(group)
        path = joinpath(datadep"pglib-opf", "pglib-opf-23.07", filename)
    else
        path = joinpath(datadep"pglib-opf", "pglib-opf-23.07", group, filename)
    end
    return path
end
