```@raw html
---
layout: home

hero:
  name: Spehulak.jl
  tagline: Spy on your LLM conversations
  description: A generative AI observability platform to help you understand what's happening inside your GenAI application.
  image:
    src: https://img.icons8.com/?size=100&id=66415&format=png&color=000000
    alt: Snowman Icon
  actions:
    - theme: brand
      text: Introduction
      link: /introduction
    - theme: alt
      text: API Reference
      link: /reference
    - theme: alt
      text: View on GitHub
      link: https://github.com/svilupp/Spehulak.jl

features:
  - icon: <img width="64" height="64" src="https://img.icons8.com/?size=100&id=46986&format=png&color=000000" alt="Integration"/>
    title: Integration with PromptingTools
    details: 'Load serialized LLM conversations and RAG results saved via PromptingTools.jl and inspect them with Spehulak.jl.'

  - icon: <img width="64" height="64" src="https://img.icons8.com/?size=100&id=46695&format=png&color=000000" alt="Navigation"/>
    title: Seamless Navigation
    details: 'Browse through conversations, sample them randomly, filter by keywords, and navigate with ease.'

  - icon: <img width="64" height="64" src="https://img.icons8.com/?size=100&id=AGmcFT8jaCcR&format=png&color=000000" alt="Automatic Replies"/>
    title: Metadata Inspection
    details: 'Inspect granular metadata like prompt template versions, LLM temperature, and models used to gain insights about your GenAI pipelines.'

---
```

````@raw html
<p style="margin-bottom:2cm"></p>

<div class="vp-doc" style="width:80%; margin:auto">

<h1> Why Spehulak.jl? </h1>
Understanding what's happening inside your GenAI model can be a challenge. Spehulak.jl is here to help.

Spehulak.jl is a generative AI observability platform that provides a set of tools for inspecting and evaluating traces saved via PromptingTools.jl. It's designed to help you make sense of your LLM conversations and RAG results.

<h2> Quick Start Guide </h2>

Install it and get started with Spehulak.jl in just two lines of code:

```julia
using Spehulak
launch() # starts an asynchronous server on 9001
```

Then head to your browser and go to <http://localhost:9001> to start exploring your conversations.

For more information, see the [Introduction](@ref) section.

<br>
Ready to gain insights into your GenAI model? Explore Spehulak.jl now!
<br><br>
</div>
````