function tab_rag_viewer()
    [
        row(p("Step 1: Select a RAG file to view...",
            class = "py-4 text-sm text-gray-500")),
        row(class = "gutter-col-sm",
            [
                cell(class = "flex col-3 items-center",
                    [
                        p("Upload Files";
                            class = "inline my-auto items-center text-lg"),
                        icon("upload_file",
                            size = "25px",
                            class = "ml-4 my-auto items-center",
                            style = "cursor:pointer;",
                            [
                                popupproxy([
                                uploader(label = "Upload", hideuploadbtn = true,
                                autoupload = true, no_thumbnails = true, multiple = true,
                                @on("rejected", :rejected),
                                @on("uploaded", :uploaded),
                                @on("finish", :finished),
                                @on("failed", :failed),
                                ref = "uploader",
                                style = "max-width: 95%; width: 95%; margin: 0 auto;")
                            ])
                            ])
                    ]),
                cell(class = "col-6",
                    [
                        textfield("Or Provide A Path", :files_path,
                        @on("keyup.enter", "files_submit = true"))]),
                cell(class = "col-3",
                    [btn(
                         "Submit", @click(:files_submit), icon = "sync", size = "sm")
                     btn(
                         "Reset", @click(:files_reset), icon = "delete", size = "sm")])
            ]),
        row(p(
            "Step 2: Browse through them (Loaded: {{rag_loaded.length}})",
            class = "pt-4 text-sm text-gray-500")),
        row(class = "gutter-col-sm",
            [
                cell(class = "flex items-center",
                btngroup(class = "py-auto items-center",
                    [btn(@click(:nav_prev), icon = "arrow_back", size = "md"),
                        btn(@click(:nav_next), icon = "arrow_forward", size = "md"),
                        btn(@click(:nav_random), icon = "casino", size = "md")])
            )
            ]),
        row([
            p("Current RAG ({{rag_show_idx}}/{{rag_loaded.length}}): ",
            class = "py-0 text-lg")]),
        htmldiv(
            [
                htmldiv(class = "pb-5",
                    [
                        ## METADATA card
                        card(
                            [cardsection("{{rag_show.title}}"; class = "text-h6 q-py-xs"),
                                cardsection(
                                    "<b>{{snakeCaseToTitleCase(meta_key)}}:</b> {{meta_value}}"; class = "q-py-xs",
                                    @for("(meta_value, meta_key) in rag_show.meta"))];
                            class = "space-y-0 p-0 m",
                            flat = true,
                            bordered = true
                        ),

                        ## Core Conversation that the user sees
                        htmldiv(class = "mt-5",
                            @for("(item, item_index) in rag_show.conv_main.messages"),
                            key! = R"item.id", [
                                messagecard("{{item.content}}",
                                    title = "{{item.title}}"; card_props = Dict(:class => R"item.class")),
                                row(class = "absolute bottom--4 right-8 text-right",
                                    [space(),
                                        span("{{item.footer}}",
                                            class = "text-xs text-gray-500 text-right")]
                                )]
                        )
                    ], @iif("!!rag_show.conv_main.messages.length")),
                expansionitem(
                    label = "Sources",
                    dense = true,
                    densetoggle = true,
                    expandseparator = true,
                    headerstyle = "bg-blue-1", [
                        card([
                        cardsection(
                            "Sources used:", class = "text-lg text-weight-bold no-padding my-auto items-center ml-4 mt-2"),
                        cardsection(ul(class = "list-disc ml-5",
                            li("{{source}}", class = "pb-2",
                                style = "white-space: pre-wrap;",
                                @for("source in rag_show.sources"))))]
                    )
                    ],
                    @iif("!!rag_show.sources.length")),
                expansionitem(
                    label = "Context",
                    dense = true,
                    densetoggle = true,
                    expandseparator = true,
                    headerstyle = "bg-blue-1", [
                        card([
                        cardsection("Context used:",
                            class = "text-lg text-weight-bold no-padding my-auto items-center ml-4 mt-2"),
                        cardsection(ul(class = "list-disc ml-5",
                            li("{{ctx}}", class = "pb-2", style = "white-space: pre-wrap;",
                                @for("ctx in rag_show.context"))))]
                    )
                    ]),
                expansionitem(
                    label = "Reranking Candidates",
                    dense = true,
                    densetoggle = true,
                    expandseparator = true,
                    headerstyle = "bg-blue-1", [
                        card(
                        [
                            cardsection(
                                "Reranking Candidates Statistics"; class = "text-h6 q-py-xs"),
                            cardsection(
                                "<b>{{snakeCaseToTitleCase(meta_key)}}:</b> {{meta_value}}"; class = "q-py-xs",
                                @for("(meta_value, meta_key) in rag_show.rerank_stats"))];
                        class = "space-y-0 p-0 m",
                        flat = true,
                        bordered = true
                    )
                    ],
                    @iif("!!Object.entries(rag_show.rerank_stats).length")),
                expansionitem(
                    label = "Embedding Candidates",
                    dense = true,
                    densetoggle = true,
                    expandseparator = true,
                    headerstyle = "bg-blue-1", [
                        card(
                        [
                            cardsection(
                                "Embedding Candidates Statistics"; class = "text-h6 q-py-xs"),
                            cardsection(
                                "<b>{{snakeCaseToTitleCase(meta_key)}}:</b> {{meta_value}}"; class = "q-py-xs",
                                @for("(meta_value, meta_key) in rag_show.emb_stats"))];
                        class = "space-y-0 p-0 m",
                        flat = true,
                        bordered = true
                    )
                    ],
                    @iif("!!Object.entries(rag_show.emb_stats).length")),
                expansionitem(
                    label = "LLM Trace: Answer",
                    dense = true,
                    densetoggle = true,
                    expandseparator = true,
                    headerstyle = "bg-blue-1", [
                        htmldiv(
                        class = "mt-5", @for("(item, item_index) in rag_show.conv_answer.messages"),
                        key! = R"item.id", [
                            messagecard("{{item.content}}",
                                title = "{{item.title}}"; card_props = Dict(:class => R"item.class")),
                            row(class = "absolute bottom--4 right-8 text-right",
                                [space(),
                                    span("{{item.footer}}",
                                        class = "text-xs text-gray-500 text-right")]
                            )]
                    )
                    ],
                    @iif("!!rag_show.conv_answer.messages.length")),
                expansionitem(
                    label = "LLM Conv.: Final Answer (Refined)",
                    dense = true,
                    densetoggle = true,
                    expandseparator = true,
                    headerstyle = "bg-blue-1", [
                        htmldiv(
                        class = "mt-5", @for("(item, item_index) in rag_show.conv_final_answer.messages"),
                        key! = R"item.id", [
                            messagecard("{{item.content}}",
                                title = "{{item.title}}"; card_props = Dict(:class => R"item.class")),
                            row(class = "absolute bottom--4 right-8 text-right",
                                [space(),
                                    span("{{item.footer}}",
                                        class = "text-xs text-gray-500 text-right")]
                            )]
                    )
                    ],
                    @iif("rag_show.has_refined_answer && !!rag_show.conv_final_answer.messages.length"))
            ],
            @iif("!!rag_show.conv_main.messages.length")
        )
    ] |> htmldiv
end