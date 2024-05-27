module Spehulak

using DataFrames, CSV, Dates
using PromptingTools
const PT = PromptingTools
using PromptingTools.Experimental.AgentTools
const AT = PromptingTools.Experimental.AgentTools
using JSON3

using GenieFramework
using GenieFramework.StippleUI.Layouts: layout
using GenieFramework.StippleUI.API: kw
const S = GenieFramework.StippleUI
using StippleDownloads

export Genie, Server, up, down

export load_conversations_from_dir
include("utils.jl")

export messagecard, templatecard
include("components.jl")

include("view_files.jl")

export ui, ui_login
include("view.jl")

export SnowConversation, SnowMessage, msg2snow
include("conversation.jl")

function __init__()
end

end #end of module