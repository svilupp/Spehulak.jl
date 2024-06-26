# Spehulak.jl 
[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://svilupp.github.io/Spehulak.jl/stable/) 
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://svilupp.github.io/Spehulak.jl/dev/) 
[![Build Status](https://github.com/svilupp/Spehulak.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/svilupp/Spehulak.jl/actions/workflows/CI.yml?query=branch%3Amain) 
[![Coverage](https://codecov.io/gh/svilupp/Spehulak.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/svilupp/Spehulak.jl) 
[![Aqua](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)


![Spy+snowman = Spehulak](docs/src/assets/spehulak.png)

> [!WARNING]
> This package is experimental and early in its development. Be careful if using it in production.

Spehulak.jl is a package for GenAI observability - helping you understand what's happening inside your GenAI model. It provides a set of tools for inspecting and evaluating the traces saved via PromptingTools.jl.

## Quick Start

Package is not yet registered, add it to your environment with:

```julia
using Pkg
Pkg.activate(".")
Pkg.add(url="https://github.com/svilupp/Spehulak.jl")
```

Then, start the app with

```julia
using Spehulak
launch() # starts an asynchronous server on 9001
```

Open the browser and navigate to `http://localhost:9001`.

## Loading Files

Spehulak can load any serialized LLM conversations or RAG results saved via PromptingTools.jl (ie, JSON files).

There are two options:
- You can use either the uploader widget (to upload one or more files from the same folder) 
- Or you can provide a directory path and click "Submit". All files in the folder and all subfolders will be loaded.

As an example, load the file `log/conversation...` in this repo.

## Viewing Files

There are two pages: 1) Conversation Browser and 2) RAG Viewer. You can change between them by clicking the icons on the left-hand side.

Conversation Browser shows all loaded conversations stacked vertically, so you can quickly browse through the traces and notice odd behaviors.

RAG Viewer always displays only a single `RAGResult` but does so with a great amount of detail (eg, user conversation, LLM chains under the hood, sources, context, ranking/embedding candidates, etc.).

To aid you with navigation, you can use the arrows in the top right corner: '<' Go to previous, '>' Go to next, and a dice icon for a random selection.
You can use these navigation tools for both Conversation Browser and RAG Viewer.

In the case of Conversation Browser, you can also filter for specific keywords (it leverages `occursin` under the hood).
Just type some keyword and press ENTER. It will keep only the conversations that contain the keyword.

> [!TIP]
> When filtering conversations, first filter with Spehulak to reduce the number of conversations displayed and then use in browser search tool to highlight all occurrences of the desired keyword.

## Frequently Asked Questions

**What can it do?**
Browse any serialized LLM conversations. If you used traced messages, we will display all the relevant metadata as well (model, templates, template versions, etc.).

**How to automatically save/log my LLM conversations?**
See [PromptingTools.jl docs](https://svilupp.github.io/PromptingTools.jl/dev/frequently_asked_questions#Automatic-Logging-/-Tracing)

Or generate a few toy examples
```julia
using PromptingTools
using PromptingTools: TracerSchema, SaverSchema, OpenAISchema, pprint

schema = OpenAISchema() |> TracerSchema |> SaverSchema

# Let's create a multi-turn conversation
conversation = aigenerate(schema,:JuliaExpertAsk; ask="Write a function to convert vector of strings into pig latin", model="gpt4o", return_all=true)
pprint(conversation)

# Let's create one more turn -- notice that we provide the past conversation as a kwarg
conversation = aigenerate(schema,"That's too complicated. Please simplify it. Think step by step first"; conversation, model="gpt4o", return_all=true)
pprint(conversation)

```

You should see a few files created in the folder `log/` - try opening them with Spehulak!

**How to save my RAG results?**

Saving `RAGResult` for future analyses is as simple as `JSON3.write(path, result)`

Full example:
```julia
using PromptingTools
using PromptingTools: pprint
using PromptingTools.Experimental.RAGTools
# to access unexported functionality
const RT = PromptingTools.Experimental.RAGTools
sentences = [
    "Search for the latest advancements in quantum computing using Julia language.",
    "How to implement machine learning algorithms in Julia with examples.",
    "Looking for performance comparison between Julia, Python, and R for data analysis.",
    "Find Julia language tutorials focusing on high-performance scientific computing.",
    "Search for the top Julia language packages for data visualization and their documentation.",
    "How to set up a Julia development environment on Windows 10.",
    "Discover the best practices for parallel computing in Julia.",
    "Search for case studies of large-scale data processing using Julia.",
    "Find comprehensive resources for mastering metaprogramming in Julia.",
    "Looking for articles on the advantages of using Julia for statistical modeling.",
    "How to contribute to the Julia open-source community: A step-by-step guide.",
    "Find the comparison of numerical accuracy between Julia and MATLAB.",
    "Looking for the latest Julia language updates and their impact on AI research.",
    "How to efficiently handle big data with Julia: Techniques and libraries.",
    "Discover how Julia integrates with other programming languages and tools.",
    "Search for Julia-based frameworks for developing web applications.",
    "Find tutorials on creating interactive dashboards with Julia.",
    "How to use Julia for natural language processing and text analysis.",
    "Discover the role of Julia in the future of computational finance and econometrics."
]
sources = map(i -> "Doc$i", 1:length(sentences))

## Build the index
index = RT.build_index(sentences; chunker_kwargs = (; sources))

## Generate an answer
question = "What are the best practices for parallel computing in Julia?"
result = airag(index; question, return_all = true)

# You can preview the RAGResult with pretty-printing
pprint(result)

# Save the RAGResult
mkpath("log")
JSON3.write("log/rag_result_20240615.json", result)
```

Now, you can inspect its details with Spehulak!

**What's Spehulak?**

"Špehulak" (pronounced "shpeh-hoo-lahk") blends "spy" and "snowman," riffing on the Czech words "špeh" for spy and "sněhulák" for snowman. It’s a fun name for an observability platform because it’s all about keeping a watchful eye, like a spy, while the snowman part plays into being cool under pressure as you sift through heaps of data plus being invisible/in the background, not being in the way. It’s perfect for diving deep into the inner workings of your LLM apps!


## Roadmap

- [ ] Better support for MultiIndex (eg, `MultiCandidateChunks`)
- [ ] Handle traced RAG files with their metadata
- [ ] Add a simple rating interface to mark files to review later

## Acknowledgments

This project would not be possible without the amazing [Stipple.jl](https://github.com/GenieFramework/Stipple.jl) from the [Genie.jl](https://github.com/GenieFramework/Genie.jl) family!