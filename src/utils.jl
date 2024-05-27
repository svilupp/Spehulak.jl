"Loads all conversations from a directory (or its sub-directories)"
function load_conversations_from_dir(dir::String)
    new_history = Dict{Symbol, Any}[]
    for (root, _, files) in walkdir(dir)
        for file in files
            if startswith(file, "conversation") && endswith(file, ".json")
                conv = PT.load_conversation(joinpath(root, file))
                file_clean = split(file, ".json")[begin] |>
                             x -> replace(x, "_" => " ") |> titlecase
                push!(new_history,
                    Dict(:name => file_clean, :label => "",
                        :path => joinpath(root, file), :messages => conv))
            end
        end
    end
    return new_history
end
