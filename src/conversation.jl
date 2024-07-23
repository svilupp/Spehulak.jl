"""
    SnowMessage

Type designed for displaying the conversation in Stipple.

"""
@kwdef mutable struct SnowMessage
    id::Int = rand(UInt16) |> Int
    content::AbstractString = ""
    title::AbstractString = ""
    class::AbstractString = ""
    footer::AbstractString = ""
    typeof::Symbol = :SystemMessage
end

"""
    SnowConversation

Container for conversations (vector of `SnowMessage`) with some extra fields for metadata.

# Fields
- `id`: Unique identifier for the conversation
- `title`: Title of the conversation, eg, the path of the file
- `class`: CSS class for the conversation
- `meta`: Metadata for the conversation
- `messages`: Vector of `SnowMessage`

"""
@kwdef mutable struct SnowConversation
    id::Int = rand(UInt16) |> Int
    title::AbstractString = ""
    class::AbstractString = ""
    meta::Dict{Symbol, Any} = Dict{Symbol, Any}()
    messages::Vector{SnowMessage} = SnowMessage[]
end

"""
    SnowRAG

Type designed for displaying the RAG conversation in Spehulak.

# Fields
- `conv_main`: The main conversation (what user sees)
- `conv_answer`: The answer conversation (default LLM chain)
- `conv_final_answer`: The final answer conversation (if we used `refine!` functionality)
- `has_refined_answer`: Whether the answer has been refined (`refine!` functionality)
- `context`: The context used to answer the question
- `sources`: The sources used to answer the question
- `emb_stats`: The embedding candidates statistics (to understand retrieval performance)
- `rerank_stats`: The reranking candidates statistics (to understand reranking performance)
- `meta`: The metadata from the first message (if it's a tracer message)

"""
@kwdef mutable struct SnowRAG
    id::Int = rand(UInt16) |> Int
    title::AbstractString = ""
    class::AbstractString = ""
    meta::Dict{Symbol, Any} = Dict{Symbol, Any}()
    context::Vector{String} = String[]
    sources::Vector{String} = String[]
    emb_stats::Dict{Symbol, <:Any} = Dict{Symbol, Any}()
    rerank_stats::Dict{Symbol, <:Any} = Dict{Symbol, Any}()
    conv_main::SnowConversation = SnowConversation()
    conv_answer::SnowConversation = SnowConversation()
    conv_final_answer::SnowConversation = SnowConversation()
    has_refined_answer::Bool = false
end

function Base.copy(msg::SnowMessage)
    deepcopy(msg)
end

role4snow(::PT.SystemMessage) = "System Message"
role4snow(::PT.UserMessage) = "User Message"
role4snow(::PT.AIMessage) = "AI Message"
role4snow(msg::PT.TracerMessage) = role4snow(msg.object)

"""
    msg2snow(msg::PT.AbstractMessage; kwargs...)

Transforms a PromptingTools message into a `SnowMessage` that Spehulak understands.
"""
function msg2snow(msg::PT.AbstractMessage; kwargs...)
    tokens_str = if PT.isaimessage(msg)
        "Tokens: $(sum(msg.tokens)), "
    else
        ""
    end
    cost_str = if PT.isaimessage(msg) && !isnothing(msg.cost) && msg.cost > 0
        "Cost: \$$(round(msg.cost;digits=2))"
    else
        ""
    end
    footer = "$(tokens_str)$(cost_str)" |>
             x -> replace(x, r",\s+$" => " ")
    SnowMessage(;
        content = msg.content, title = role4snow(msg),
        class = PT.isaimessage(msg) ? "bg-grey-3" : "",
        typeof = nameof(typeof(msg)), footer)
end
"""
    msg2snow(msg::PT.AbstractTracerMessage; kwargs...)

Transforms a Tracer message into a `SnowMessage` that Spehulak understands.
"""
function msg2snow(msg::PT.AbstractTracerMessage; kwargs...)
    model_str = if !isnothing(msg.model)
        "Model: $(msg.model), "
    else
        ""
    end
    duration_str = if !isnothing(msg.time_received) && !isnothing(msg.time_sent)
        val = Dates.value(msg.time_received - msg.time_sent) / 1000
        "Duration: $(round(val; digits=1))s, "
    else
        ""
    end
    tokens_str = if PT.isaimessage(msg)
        "Tokens: $(sum(msg.tokens)), "
    else
        ""
    end
    cost_str = if PT.isaimessage(msg) && msg.cost > 0
        "Cost: \$$(round(msg.cost;digits=2))"
    else
        ""
    end
    footer = "$(model_str)$(duration_str)$(tokens_str)$(cost_str)" |>
             x -> replace(x, r",\s+$" => " ")
    SnowMessage(;
        content = msg.content, title = role4snow(msg),
        class = PT.isaimessage(msg) ? "bg-grey-3" : "",
        typeof = nameof(typeof(msg)), footer)
end

"""
    msg2snow(vect::AbstractVector{<:PT.AbstractMessage}; path::AbstractString = "")

Transforms a vector of messages into a `SnowConversation` that Spehulak understands.
"""
function msg2snow(vect::AbstractVector{<:PT.AbstractMessage}; path::AbstractString = "")
    messages = map(msg2snow, vect)
    ## grab the metadata from the first msg that has it
    meta = if length(messages) > 0 && any(PT.istracermessage, vect)
        msg = filter(PT.istracermessage, vect)[1]
        meta_info = isnothing(msg.meta) ? Dict{Symbol, Any}() :
                    Dict{Symbol, Any}(msg.meta...)
        Dict{Symbol, Any}(meta_info..., :model => msg.model)
    else
        Dict{Symbol, Any}()
    end
    SnowConversation(; messages, title = path, meta)
end

"""
    msg2snow(rag::RT.RAGResult; path::AbstractString = "")

Transforms a `RAGResult` into a `SnowRAG` that Spehulak understands.
"""
function msg2snow(rag::RT.RAGResult; path::AbstractString = "")
    # TODO: Fix metadata loading if wrapped object
    ## grab the metadata from the first msg that has it
    # meta = if length(messages) > 0 && any(PT.istracermessage, vect)
    #     msg = filter(PT.istracermessage, vect)[1]
    #     Dict{Symbol, Any}(msg.meta..., :model => msg.model)
    # else
    #     Dict{Symbol, Any}()
    # end
    ## Core conversation
    last_msg = PT.last_message(rag) |>
               x -> !isnothing(x) ? x : PT.AIMessage(; content = rag.final_answer)
    conv_main = msg2snow([
        PT.UserMessage(;
            content = "Question:\n- " * join(rag.rephrased_questions, "\n- ")),
        last_msg
    ])
    if rag.reranked_candidates isa RT.MultiCandidateChunks
        @warn "MultiCandidateChunks detected. Scores reported might be incorrect - please open an Issue."
    end
    context = String[]
    for i in eachindex(rag.context)
        source_str = if i <= length(rag.sources)
            "Source: $(rag.sources[i])\n"
        else
            ""
        end
        ## skip this step if it's manually added appendded sources
        if i > length(rag.reranked_candidates.positions)
            txt = "Context ID $i\n$(source_str)-----\nContext:\n-----\n$(rag.context[i])\n\n"
            push!(context, txt)
            continue
        end
        ## Simplification for CandidateChunks, it might be incorrect for MulticandidateChunks 
        # - we would need to matcht the index_id as well
        ctx_idx = rag.reranked_candidates.positions[i]
        emb_idx = findfirst(==(ctx_idx), rag.emb_candidates.positions)
        emb_score = isnothing(emb_idx) ? 0.0 : rag.emb_candidates.scores[emb_idx]
        ##
        rerank_score = rag.reranked_candidates.scores[i]
        txt = "Context ID $i\n$(source_str)Embed. score: $(round(emb_score;digits=2)), Rerank. score: $(round(rerank_score;digits=2))\n-----\nContext:\n-----\n$(rag.context[i])\n\n"
        push!(context, txt)
    end
    emb_stats = isempty(rag.emb_candidates) ? Dict{Symbol, Any}() :
                Dict{Symbol, Any}(
        :min_score => minimum(rag.emb_candidates.scores),
        :max_score => maximum(rag.emb_candidates.scores),
        :mean_score => mean(rag.emb_candidates.scores),
        :std_score => std(rag.emb_candidates.scores),
        :count => length(rag.emb_candidates.scores)
    )
    rerank_stats = isempty(rag.reranked_candidates) ? Dict{Symbol, Any}() :
                   Dict{Symbol, Any}(
        :min_score => minimum(rag.reranked_candidates.scores),
        :max_score => maximum(rag.reranked_candidates.scores),
        :mean_score => mean(rag.reranked_candidates.scores),
        :std_score => std(rag.reranked_candidates.scores),
        :count => length(rag.reranked_candidates.scores)
    )
    conv_answer = get(rag.conversations, :answer, PT.AbstractMessage[]) |> msg2snow
    conv_final_answer = get(rag.conversations, :final_answer, PT.AbstractMessage[]) |>
                        msg2snow
    has_refined_answer = get(rag.conversations, :final_answer, PT.AbstractMessage[]) !=
                         get(rag.conversations, :answer, PT.AbstractMessage[])
    ## Build the object
    SnowRAG(; conv_main, title = path,
        context, rag.sources, emb_stats, rerank_stats,
        conv_answer, conv_final_answer, has_refined_answer
    )
end
