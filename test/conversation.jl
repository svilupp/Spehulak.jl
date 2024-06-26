using Spehulak: msg2snow, SnowMessage, SnowConversation, SnowRAG

@testset "msg2snow" begin
    # Test case 1: Check if msg2snow correctly processes a basic message
    msg = PT.AIMessage(; content = "hello", tokens = (2, 1), cost = 0.1)
    snow_msg = msg2snow(msg)
    @test snow_msg.content == "hello"
    @test snow_msg.title == "AI Message"
    @test snow_msg.class == "bg-grey-3"
    @test snow_msg.footer == "Tokens: 3, Cost: \$0.1"

    # Test case 2: User message
    msg_user = PT.UserMessage(; content = "hello")
    snow_msg_user = msg2snow(msg_user)
    @test snow_msg_user.content == "hello"
    @test snow_msg_user.title == "User Message"
    @test snow_msg_user.class == ""
    @test snow_msg_user.footer == ""

    # Test case 3: Tracer message
    msg_traced = PT.TracerMessage(
        msg; model = "abc")
    snow_msg_traced = msg2snow(msg_traced)
    @test snow_msg_traced.content == "hello"
    @test snow_msg_traced.class == "bg-grey-3"
    @test snow_msg_traced.footer == "Model: abc, Tokens: 3, Cost: \$0.1"

    # Conversation
    conv = [msg_traced, msg_user, msg]
    snow_conv = msg2snow(conv; path = "a/b/c")
    @test length(snow_conv.messages) == 3
    @test snow_conv.messages[1].content == snow_msg_traced.content
    @test snow_conv.messages[2].content == snow_msg_user.content
    @test snow_conv.messages[3].content == snow_msg.content
    @test snow_conv.class == ""
    @test snow_conv.title == "a/b/c"

    # RAGResult
    res = RT.RAGResult(;
        question = "hello",
        final_answer = "yes",
        context = ["world"],
        sources = ["my"]    # conversations = Dict(:answer => conv)
    )
    snow_res = msg2snow(res; path = "d/e/f")
    @test snow_res.title == "d/e/f"
    @test snow_res.context == ["Context ID 1\n-----\nContext:\n-----\nworld\n\n"]
    @test snow_res.sources == ["my"]
    @test snow_res.class == ""
    @test snow_res.conv_main isa SnowConversation
    @test length(snow_res.conv_main.messages) == 2
    @test snow_res.conv_main.messages[1].content == "Question:\n- hello"
    @test snow_res.conv_main.messages[2].content == "yes"
end
