## Individual Tabs
function tab_files()
    [
        h3("Files Browser"),
        tab_files_upload(),
        separator(),
        tab_files_convos()
    ] |> htmldiv
end

function tab_rag()
    [h3("RAG Viewer"),
        span("Under construction...")
    ] |> htmldiv
end

function tab_ratings()
    [h3("Ratings"),
        span("Under construction..."),
        row([
            p("Upload Files"; class = "inline my-auto items-center text-lg"),
            icon("download", size = "25px", style = "cursor:pointer;",
                class = "ml-4 my-auto items-center",
                @on(:click, :download_csv))
        ])        ## 
    ] |> htmldiv
end

## Page Container
function ui()
    layout(view = "hHh Lpr lff", title = "Spehulak", head_content = "",
        [
            Genie.Assets.favicon_support(),
            ##    
            quasar(:header,
                style = "background:blue-grey-6",
                [toolbar(
                    [
                    btn(; dense = true, flat = true, round = true, icon = "menu",
                        @click("left_drawer_open = !left_drawer_open")),
                    toolbartitle("Spehulak")
                ])]),
            drawer(bordered = "", fieldname = "left_drawer_open", side = "left",
                var":mini" = "ministate", var"@mouseover" = "ministate = false",
                var"@mouseout" = "ministate = true", var"mini-to-overlay" = true,
                width = "170", breakpoint = 200,
                class = "bg-black",
                list(bordered = true, separator = true,
                    [
                        item(clickable = "", vripple = "",
                            @click("selected_page = 'files'"),
                            [
                                itemsection(avatar = true, icon("folder_open")),
                                itemsection("Files Browser")
                            ]),
                        item(clickable = "", vripple = "",
                            @click("selected_page = 'rag'"),
                            [
                                itemsection(avatar = true, icon("school")),
                                itemsection("RAG")
                            ]),
                        item(clickable = "", vripple = "",
                            @click("selected_page = 'ratings'"),
                            [
                                itemsection(avatar = true, icon("reviews")),
                                itemsection("Ratings")
                            ])
                    ]
                )),
            page_container(class = "mx-8",
                [
                    Html.div(class = "", @iif("selected_page == 'files'"),
                        tab_files()),
                    Html.div(class = "", @iif("selected_page == 'rag'"),
                        tab_rag()),
                    Html.div(class = "", @iif("selected_page == 'ratings'"), tab_ratings())]),
            quasar(
                :footer, reveal = true, bordered = false,
                class = "bg-white text-primary text-caption text-center",
                [
                    p([span("Powered by "),
                    a(href = "https://github.com/GenieFramework/Stipple.jl",
                        "Stipple.jl from the GenieFramework. "),
                    span("Icons by "), a(href = "https://icons8.com/about", "Icons8")])
                ])            ##
        ])
end