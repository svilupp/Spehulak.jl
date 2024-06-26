"""
    launch(
        port::Int = 9001, host::String = "127.0.0.1";
        async::Bool = true)

Launches Spehulak in the browser.

Defaults to: `http://127.0.0.1:9001`. 
This is a convenience wrapper around `Genie.up`, to customize the server configuration use `Genie.up()` and `Genie.config`.

# Arguments
- `port::Int = 9001`: The port to launch the server on.
- `host::String = "127.0.0.1"`: The host to launch the server on.
- `async::Bool = true`: Whether to launch the server asynchronously, ie, in the background.
"""
function launch(
        port::Int = 9001, host::String = "127.0.0.1";
        async::Bool = true)
    # include(joinpath(@__DIR__, ",,", "app.jl")) # hack for hot-reloading when fixing things
    Genie.loadapp()
    up(port, host; async)
end