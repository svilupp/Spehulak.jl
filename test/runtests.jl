using Spehulak
using Test
using Aqua

@testset "Spehulak.jl" begin
    @testset "Code quality (Aqua.jl)" begin
        Aqua.test_all(Spehulak; ambiguities = false)
    end
    # Write your tests here.
end