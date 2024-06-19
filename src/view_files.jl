# Blocks of the FILES tab
function tab_files_upload()
    # Type path or select!
    [
        row(p("Step 1: Select some conversation to view...",
            class = "py-4 text-sm text-gray-500")),
        row(class = "gutter-col-sm",
            [
                cell(class = "flex col-3 items-center",
                    [
                        p("Upload Files"; class = "inline my-auto items-center text-lg"),
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
            "Step 2: Filter down to conversations that contain... Or just browse through them",
            class = "pt-4 text-sm text-gray-500")),
        row(class = "gutter-col-sm",
            [
                cell(
                    textfield("With the following occurring...", :files_filter,
                        hint = "Enter a keyword you're looking for - follows occursin logic"),
                    @on("keyup.enter", "files_filter_submit = true")),
                cell(class = "flex items-center",
                    btngroup(class = "py-auto items-center",
                        [btn(@click(:files_prev), icon = "arrow_back", size = "md"),
                            btn(@click(:files_next), icon = "arrow_forward", size = "md"),
                            btn(@click(:files_random), icon = "casino", size = "md")])
                )
            ])
    ] |> htmldiv
end

function tab_files_convos()
    [p("Conversations Loaded: ", class = "py-5 text-lg"),
        htmldiv(@for("(convo, index) in files_show"),
            key! = R"convo.id",
            id! = R"'convo_'+index",
            class = "py-5",
            [separator(),
                ## METADATA card
                card(
                    [cardsection("{{convo.title}}"; class = "text-h6 q-py-xs"),
                        cardsection(
                            "<b>{{snakeCaseToTitleCase(meta_key)}}:</b> {{meta_value}}"; class = "q-py-xs",
                            @for("(meta_value, meta_key) in convo.meta"))];
                    class = "space-y-0 p-0 m",
                    flat = true,
                    bordered = true
                ),

                ## MESSAGES
                htmldiv(class = "mt-5", @for("(item, item_index) in convo.messages"),
                    key! = R"item.id", [
                        messagecard("{{item.content}}",
                            title = "{{item.title}}"),
                        row(class = "absolute bottom--4 right-8 text-right",
                            [space(),
                                span("{{item.footer}}",
                                    class = "text-xs text-gray-500 text-right")]
                        )]
                )
            ])
    ] |> htmldiv
end