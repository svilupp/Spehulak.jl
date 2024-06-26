using Spehulak
using PromptingTools
using PromptingTools.Experimental.RAGTools
const PT = PromptingTools
const RT = PromptingTools.Experimental.RAGTools
using Test
using Aqua

@testset "Spehulak.jl" begin
    @testset "Code quality (Aqua.jl)" begin
        Aqua.test_all(Spehulak; ambiguities = false)
    end
    @testset "RAGTools.jl" begin
        include("conversation.jl")
    end
end