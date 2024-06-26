# Utility script for customized launches via ENV
# see documentation for Genie.config to learn about more options!
using Pkg
Pkg.activate(".")
using GenieFramework
ENV["GENIE_HOST"] = "127.0.0.1"
ENV["PORT"] = "9001"
## ENV["GENIE_ENV"] = "prod"
include("app.jl") # hack for hot-reloading when fixing things
Genie.loadapp();
up(async = false);
