using Spehulak
using Documenter

DocMeta.setdocmeta!(Spehulak, :DocTestSetup, :(using Spehulak); recursive = true)

makedocs(;
    modules = [Spehulak],
    authors = "J S <49557684+svilupp@users.noreply.github.com> and contributors",
    sitename = "Spehulak.jl",
    ## format=Documenter.HTML(;
    ##     canonical="https://svilupp.github.io/Spehulak.jl",
    ##     edit_link="main",
    ##     assets=String[],
    ## ),
    format = DocumenterVitepress.MarkdownVitepress(
        repo = "https://github.com/svilupp/Spehulak.jl",
        devbranch = "main",
        devurl = "dev",
        deploy_url = "svilupp.github.io/Spehulak.jl"
    ),
    draft = false,
    source = "src",
    build = "build",
    pages = [
        "Home" => "index.md",
        "Introduction" => "introduction.md",
        "API Reference" => "reference.md"
    ]
)

deploydocs(;
    repo = "github.com/svilupp/Spehulak.jl",
    devbranch = "main"
)
