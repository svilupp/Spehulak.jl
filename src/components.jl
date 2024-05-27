function messagecard(content; title = "", title_props = Dict(),
        content_props = Dict(), card_props = Dict())
    card(
        [
            cardsection(title; class = "text-lg q-py-xs", kw(title_props)...),
            cardsection(content; class = "q-py-xs",
                style = "white-space: pre-wrap;", kw(content_props)...)];
        flat = true,
        bordered = true,
        kw(card_props)...)
end

function metadatacard(; title = "", subtitle = "", metadata = "")
    card(
        [cardsection(title; class = "text-h6 q-py-xs"),
            cardsection(subtitle; class = "text-subtitle2 q-py-xs"),
            cardsection(metadata; class = "q-py-xs")
        ];
        class = "space-y-0 p-0 m",
        flat = true,
        bordered = true
    )
end
