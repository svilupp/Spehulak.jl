function check_if_rag(file::String)
    txt = read(file, String)
    return occursin("rephrased_questions", txt) && occursin("emb_candidates", txt) &&
           occursin("reranked_candidates", txt)
end

function load_object(path::String)
    file = basename(path)
    file_clean = split(file, ".json")[begin] |>
                 x -> replace(x, "_" => " ") |> titlecase
    rag_flag = check_if_rag(path)
    if rag_flag
        try
            ## attempt parsing a RAG
            rag = JSON3.read(path, RT.RAGResult)
            Dict(:name => file_clean, :label => "", :path => path,
                :rag => rag)
        catch e
            @info "Error loading RAG file $path (Error: $e)"
            nothing
        end
    else
        ## attempt parsing a conversation
        try
            conv = PT.load_conversation(path)
            Dict(:name => file_clean, :label => "",
                :path => path, :messages => conv)
        catch e
            @info "Error loading CONVERSATION file $path (Error: $e)"
            nothing
        end
    end
end

"Loads all conversations and RAGResults from a directory (or its sub-directories)"
function load_objects_from_dir(dir::String)
    new_convo = Dict{Symbol, Any}[]
    new_rags = Dict{Symbol, Any}[]
    for (root, _, files) in walkdir(dir)
        for file in files
            path = joinpath(root, file)
            ## skip if not JSON
            !endswith(file, ".json") && continue
            ## Load object
            obj = load_object(path)
            isnothing(obj) && continue
            haskey(obj, :rag) && push!(new_rags, obj)
            haskey(obj, :messages) && push!(new_convo, obj)
        end
    end
    return new_convo, new_rags
end
