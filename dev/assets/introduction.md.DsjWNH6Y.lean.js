import{_ as i,c as a,a5 as n,o as t}from"./chunks/framework.BWAon143.js";const e="/svilupp.github.io/Spehulak.jl/dev/assets/spehulak.BgBmuTli.png",E=JSON.parse('{"title":"Spehulak","description":"","frontmatter":{},"headers":[],"relativePath":"introduction.md","filePath":"introduction.md","lastUpdated":null}'),l={name:"introduction.md"};function h(p,s,k,o,r,d){return t(),a("div",null,s[0]||(s[0]=[n('<h1 id="spehulak" tabindex="-1">Spehulak <a class="header-anchor" href="#spehulak" aria-label="Permalink to &quot;Spehulak&quot;">​</a></h1><p>Welcome to the documentation for <a href="https://github.com/svilupp/Spehulak.jl" target="_blank" rel="noreferrer">Spehulak.jl</a>.</p><p><img src="'+e+`" alt=""></p><p>Spehulak.jl is a package for GenAI observability - helping you understand what&#39;s happening inside your GenAI model. It provides a set of tools for inspecting and evaluating the traces saved via PromptingTools.jl.</p><h2 id="Quick-Start" tabindex="-1">Quick Start <a class="header-anchor" href="#Quick-Start" aria-label="Permalink to &quot;Quick Start {#Quick-Start}&quot;">​</a></h2><p>Add it to your environment simply with:</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">using</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> Pkg</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">Pkg</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">.</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">activate</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;.&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">Pkg</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">.</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">add</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;Spehulak&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">using</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> Spehulak</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">launch</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">() </span><span style="--shiki-light:#6A737D;--shiki-dark:#6A737D;"># starts an asynchronous server on 9001</span></span></code></pre></div><p>Open the browser and navigate to <code>http://localhost:9001</code>.</p><h2 id="Loading-Files" tabindex="-1">Loading Files <a class="header-anchor" href="#Loading-Files" aria-label="Permalink to &quot;Loading Files {#Loading-Files}&quot;">​</a></h2><p>Spehulak can load any serialized LLM conversations or RAG results saved via PromptingTools.jl (ie, JSON files).</p><p>There are two options:</p><ul><li><p>You can use either the uploader widget (to upload one or more files from the same folder)</p></li><li><p>Or you can provide a directory path and click &quot;Submit&quot;. All files in the folder and all subfolders will be loaded.</p></li></ul><p>As an example, load the file <code>log/conversation...</code> in this repo.</p><h2 id="Viewing-Files" tabindex="-1">Viewing Files <a class="header-anchor" href="#Viewing-Files" aria-label="Permalink to &quot;Viewing Files {#Viewing-Files}&quot;">​</a></h2><p>There are two pages: 1) Conversation Browser and 2) RAG Viewer. You can change between them by clicking the icons on the left-hand side.</p><p>Conversation Browser shows all loaded conversations stacked vertically, so you can quickly browse through the traces and notice odd behaviors.</p><p>RAG Viewer always displays only a single <code>RAGResult</code> but does so with a great amount of detail (eg, user conversation, LLM chains under the hood, sources, context, ranking/embedding candidates, etc.).</p><p>To aid you with navigation, you can use the arrows in the top right corner: &#39;&lt;&#39; Go to previous, &#39;&gt;&#39; Go to next, and a dice icon for a random selection. You can use these navigation tools for both Conversation Browser and RAG Viewer.</p><p>In the case of Conversation Browser, you can also filter for specific keywords (it leverages <code>occursin</code> under the hood). Just type some keyword and press ENTER. It will keep only the conversations that contain the keyword.</p><div class="tip custom-block github-alert"><p class="custom-block-title">When filtering conversations, first filter with Spehulak to reduce the number of conversations displayed and then use in browser search tool to highlight all occurrences of the desired keyword.</p><p></p></div><h2 id="Frequently-Asked-Questions" tabindex="-1">Frequently Asked Questions <a class="header-anchor" href="#Frequently-Asked-Questions" aria-label="Permalink to &quot;Frequently Asked Questions {#Frequently-Asked-Questions}&quot;">​</a></h2><p><strong>What can it do?</strong> Browse any serialized LLM conversations. If you used traced messages, we will display all the relevant metadata as well (model, templates, template versions, etc.).</p><p><strong>How to automatically save/log my LLM conversations?</strong> See <a href="https://svilupp.github.io/PromptingTools.jl/dev/frequently_asked_questions#Automatic-Logging-/-Tracing" target="_blank" rel="noreferrer">PromptingTools.jl docs</a></p><p>Or generate a few toy examples</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">using</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> PromptingTools</span></span>
<span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">using</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> PromptingTools</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">:</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> TracerSchema, SaverSchema, OpenAISchema, pprint</span></span>
<span class="line"></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">schema </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> OpenAISchema</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">() </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">|&gt;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> TracerSchema </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">|&gt;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> SaverSchema</span></span>
<span class="line"></span>
<span class="line"><span style="--shiki-light:#6A737D;--shiki-dark:#6A737D;"># Let&#39;s create a multi-turn conversation</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">conversation </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> aigenerate</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(schema,</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">:JuliaExpertAsk</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">; ask</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;Write a function to convert vector of strings into pig latin&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, model</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;gpt4o&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, return_all</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">true</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">pprint</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(conversation)</span></span>
<span class="line"></span>
<span class="line"><span style="--shiki-light:#6A737D;--shiki-dark:#6A737D;"># Let&#39;s create one more turn -- notice that we provide the past conversation as a kwarg</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">conversation </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> aigenerate</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(schema,</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;That&#39;s too complicated. Please simplify it. Think step by step first&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">; conversation, model</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;gpt4o&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, return_all</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">true</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">pprint</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(conversation)</span></span></code></pre></div><p>You should see a few files created in the folder <code>log/</code> - try opening them with Spehulak!</p><p><strong>How to save my RAG results?</strong></p><p>Saving <code>RAGResult</code> for future analyses is as simple as <code>JSON3.write(path, result)</code></p><p>Full example:</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">using</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> PromptingTools</span></span>
<span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">using</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> PromptingTools</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">:</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> pprint</span></span>
<span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">using</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> PromptingTools</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">.</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">Experimental</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">.</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">RAGTools</span></span>
<span class="line"><span style="--shiki-light:#6A737D;--shiki-dark:#6A737D;"># to access unexported functionality</span></span>
<span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">const</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> RT </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> PromptingTools</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">.</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">Experimental</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">.</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">RAGTools</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">sentences </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> [</span></span>
<span class="line"><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">    &quot;Search for the latest advancements in quantum computing using Julia language.&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">    &quot;How to implement machine learning algorithms in Julia with examples.&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">    &quot;Looking for performance comparison between Julia, Python, and R for data analysis.&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">    &quot;Find Julia language tutorials focusing on high-performance scientific computing.&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">    &quot;Search for the top Julia language packages for data visualization and their documentation.&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">    &quot;How to set up a Julia development environment on Windows 10.&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">    &quot;Discover the best practices for parallel computing in Julia.&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">    &quot;Search for case studies of large-scale data processing using Julia.&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">    &quot;Find comprehensive resources for mastering metaprogramming in Julia.&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">    &quot;Looking for articles on the advantages of using Julia for statistical modeling.&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">    &quot;How to contribute to the Julia open-source community: A step-by-step guide.&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">    &quot;Find the comparison of numerical accuracy between Julia and MATLAB.&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">    &quot;Looking for the latest Julia language updates and their impact on AI research.&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">    &quot;How to efficiently handle big data with Julia: Techniques and libraries.&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">    &quot;Discover how Julia integrates with other programming languages and tools.&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">    &quot;Search for Julia-based frameworks for developing web applications.&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">    &quot;Find tutorials on creating interactive dashboards with Julia.&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">    &quot;How to use Julia for natural language processing and text analysis.&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">    &quot;Discover the role of Julia in the future of computational finance and econometrics.&quot;</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">]</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">sources </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> map</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(i </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">-&gt;</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;"> &quot;Doc</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">$i</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, </span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">1</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">:</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">length</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(sentences))</span></span>
<span class="line"></span>
<span class="line"><span style="--shiki-light:#6A737D;--shiki-dark:#6A737D;">## Build the index</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">index </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> RT</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">.</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">build_index</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(sentences; chunker_kwargs </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> (; sources))</span></span>
<span class="line"></span>
<span class="line"><span style="--shiki-light:#6A737D;--shiki-dark:#6A737D;">## Generate an answer</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">question </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;"> &quot;What are the best practices for parallel computing in Julia?&quot;</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">result </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> airag</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(index; question, return_all </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> true</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span>
<span class="line"></span>
<span class="line"><span style="--shiki-light:#6A737D;--shiki-dark:#6A737D;"># You can preview the RAGResult with pretty-printing</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">pprint</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(result)</span></span>
<span class="line"></span>
<span class="line"><span style="--shiki-light:#6A737D;--shiki-dark:#6A737D;"># Save the RAGResult</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">mkpath</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;log&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">JSON3</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">.</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">write</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;log/rag_result_20240615.json&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, result)</span></span></code></pre></div><p>Now, you can inspect its details with Spehulak!</p><p><strong>What&#39;s Spehulak?</strong></p><p>&quot;Špehulak&quot; (pronounced &quot;shpeh-hoo-lahk&quot;) blends &quot;spy&quot; and &quot;snowman,&quot; riffing on the Czech words &quot;špeh&quot; for spy and &quot;sněhulák&quot; for snowman. It’s a fun name for an observability platform because it’s all about keeping a watchful eye, like a spy, while the snowman part plays into being cool under pressure as you sift through heaps of data plus being invisible/in the background, not being in the way. It’s perfect for diving deep into the inner workings of your LLM apps!</p><h2 id="roadmap" tabindex="-1">Roadmap <a class="header-anchor" href="#roadmap" aria-label="Permalink to &quot;Roadmap&quot;">​</a></h2><ul><li><p>[ ] Better support for MultiIndex (eg, <code>MultiCandidateChunks</code>)</p></li><li><p>[ ] Handle traced RAG files with their metadata</p></li><li><p>[ ] Add a simple rating interface to mark files to review later</p></li></ul><h2 id="acknowledgments" tabindex="-1">Acknowledgments <a class="header-anchor" href="#acknowledgments" aria-label="Permalink to &quot;Acknowledgments&quot;">​</a></h2><p>This project would not be possible without the amazing <a href="https://github.com/GenieFramework/Stipple.jl" target="_blank" rel="noreferrer">Stipple.jl</a> from the <a href="https://github.com/GenieFramework/Genie.jl" target="_blank" rel="noreferrer">Genie.jl</a> family!</p>`,38)]))}const u=i(l,[["render",h]]);export{E as __pageData,u as default};
