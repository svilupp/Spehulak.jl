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

@kwdef mutable struct SnowConversation
    id::Int = rand(UInt16) |> Int
    title::AbstractString = ""
    class::AbstractString = ""
    meta::Dict{Symbol, Any} = Dict{Symbol, Any}()
    messages::Vector{SnowMessage} = SnowMessage[]
end

function Base.copy(msg::SnowMessage)
    deepcopy(msg)
end

role4snow(::PT.SystemMessage) = "System Message"
role4snow(::PT.UserMessage) = "User Message"
role4snow(::PT.AIMessage) = "AI Message"
role4snow(msg::PT.TracerMessage) = role4snow(msg.object)

function msg2snow(msg::PT.AbstractMessage; kwargs...)
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
    footer = "$(tokens_str)$(cost_str)" |>
             x -> replace(x, r",\s+$" => " ")
    SnowMessage(;
        content = msg.content, title = role4snow(msg),
        class = PT.isaimessage(msg) ? "bg-grey-3" : "",
        typeof = nameof(typeof(msg)), footer)
end
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
function msg2snow(vect::AbstractVector{<:PT.AbstractMessage}; path::AbstractString = "")
    messages = map(msg2snow, vect)
    ## grab the metadata from the first msg that has it
    meta = if length(messages) > 0 && any(PT.istracermessage, vect)
        msg = filter(PT.istracermessage, vect)[1]
        Dict{Symbol, Any}(msg.meta..., :model => msg.model)
    else
        Dict{Symbol, Any}()
    end
    SnowConversation(; messages, title = path, meta)
end
