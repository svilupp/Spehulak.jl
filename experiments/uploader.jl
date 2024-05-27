row([
    filefield("Select a file", v__model = :singlef_path, name = "singlef_path",
        @on(:input, "handleFileInput")                ## @on("change", "singlef_submit = !singlef_submit")
    ),
    btn("Submit", @click(:singlef_submit), icon = "refresh")
]),
textfield(
    v__model = "singlef_path", type = "file", directory = "", webkitdirectory = "",
    @on(:input, "handleFolderSelect"), placeholder = "Select a folder"),
uploader(
    accept = ".json", label = "Upload new files", #url = "/upload", accept = ".txt",
    @on("rejected", :rejected),
    @on("uploaded", :uploaded),
    @on("finish", :finished),
    @on("failed", :failed)),
quasar(:uploader, label = "Simple upload", url = "/upload", accept = ".json",
    autoupload = true, hideuploadbtn = true, multiple = false),