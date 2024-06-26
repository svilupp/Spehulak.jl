module App
using Spehulak
using Random
using PromptingTools
const PT = PromptingTools
using PromptingTools.Experimental.AgentTools
const AT = PromptingTools.Experimental.AgentTools
using PromptingTools.Experimental.RAGTools
const RT = PromptingTools.Experimental.RAGTools
using Base64
using GenieFramework
using StippleDownloads, DataFrames, CSV
@genietools

Stipple.Layout.add_script("https://cdn.tailwindcss.com")

#! CONFIGURATION

@appname SpehulakApp

@app begin
    # layout and page management
    @in left_drawer_open = true
    @in selected_page = "conversations"
    @in ministate = true
    # configuration
    # Multi-file view
    @in files_path = ""
    @in files_filter = ""
    @in files_filter_regex = ""
    @in files_filter_submit = false
    @in files_submit = false
    @in files_reset = false
    ## Navigation
    @in nav_prev = false
    @in nav_next = false
    @in nav_random = false
    ## Conversation show
    @out files_loaded = Vector{SnowConversation}()
    @out files_show = Vector{SnowConversation}()
    ## RAG files to show
    @out rag_loaded = SnowRAG[]
    @in rag_show_idx = 0
    @out rag_show = SnowRAG()
    # Ratings
    @private df_ratings = DataFrame()
    @out ratings_data = DataTable()
    @out ratings_pagination = DataTablePagination(rows_per_page = 100)
    # Dashboard logic
    @onchange isready begin
        @info "> Dashboard is ready!"
    end
    @event rejected begin
        @info "> File rejected"
        notify(__model__, "File rejected. Please make sure it is a valid image file.")
    end
    @event failed begin
        @info "> Upload failed"
        notify(__model__, "File upload failed. Please try again.")
    end
    @event download_csv begin
        @info "> Download started"
        try
            io = IOBuffer()
            CSV.write(io, df_ratings)
            seekstart(io)
            dttm_str = Dates.format(now(), dateformat"yyyymmdd_HHMMSS")
            download_binary(__model__, take!(io), "ratings__$(dttm_str).csv")
        catch ex
            @info "Error during download: $(ex)"
        end
    end
    ### Files
    @onchange fileuploads begin
        if !isempty(fileuploads) && haskey(fileuploads, "path")
            path = fileuploads["path"]
            @info "> File was uploaded: $(path)"
            ## SKIP RAG objects for now
            obj = load_object(path)
            if !isnothing(obj) && haskey(obj, :messages)
                files_loaded = push!(
                    files_loaded, msg2snow(obj[:messages]; path = fileuploads["name"]))
                files_show = copy(files_loaded)
            elseif !isnothing(obj) && haskey(obj, :rag)
                rag_loaded = push!(
                    rag_loaded, msg2snow(obj[:rag]; path = fileuploads["name"]))
                rag_show_idx = length(rag_loaded)
                !iszero(rag_show_idx) && (rag_show = rag_loaded[rag_show_idx])
            else
                @info "> No file loaded."
            end
        end
    end
    @onbutton files_submit begin
        @info "> Path provided: $(files_path)"
        dir_path = isdir(files_path) ? files_path : dirname(files_path)
        new_convo, new_rags = load_objects_from_dir(dir_path)
        @info "> Loaded $(length(new_convo)) conversations and $(length(new_rags)) RAGs from disk"
        ## Load conversations
        files_loaded = [msg2snow(c[:messages]; path = c[:path]) for c in new_convo]
        files_show = copy(files_loaded)
        ## Load RAGs
        rag_loaded = [msg2snow(r[:rag]; path = r[:path]) for r in new_rags]
        rag_show_idx = length(rag_loaded)
        !iszero(rag_show_idx) && (rag_show = rag_loaded[rag_show_idx])
        ## Scroll to the bottom of the conversation (if there were multiple overview messages generated)
        Base.notify(__model__,
            "Loaded $(length(new_convo)) conversations (page \"Conversation Browser\") and $(length(new_rags)) RAGs (page \"RAG Browser\").")
        Base.run(__model__, raw"window.scrollTo(0, document.body.scrollHeight);")
    end
    @onbutton files_reset begin
        @info "> Resetting files"
        files_show = empty!(files_show)
        files_loaded = empty!(files_loaded)
        rag_show = SnowRAG()
        rag_show_idx = 0
        rag_loaded = empty!(rag_loaded)
        Base.run(__model__, raw"this.$refs.uploader.reset()")
    end
    ### Navigation
    @onbutton files_filter_submit begin
        @info "> Filtering files with \"$(files_filter)\""
        if isempty(files_filter)
            files_show = copy(files_loaded)
        else
            ## Look for any message containing
            files_show = filter(files_loaded) do conv
                any(conv.messages) do msg
                    occursin(files_filter, msg.content)
                end
            end
        end
    end
    @onbutton nav_prev begin
        @info "> Nav to previous item"
        if selected_page == "conversations"
            isempty(files_loaded) && return
            Base.run(__model__, raw"this.scrollToElementPrevious()")
        elseif selected_page == "rag"
            isempty(rag_loaded) && return
            rag_show_idx = max(rag_show_idx - 1, firstindex(rag_loaded))
            rag_show = rag_loaded[rag_show_idx]
        end
    end
    @onbutton nav_next begin
        @info "> Nav to next item"
        if selected_page == "conversations"
            isempty(files_loaded) && return
            Base.run(__model__, raw"this.scrollToElementNext()")
        elseif selected_page == "rag"
            isempty(rag_loaded) && return
            rag_show_idx = min(rag_show_idx + 1, lastindex(rag_loaded))
            rag_show = rag_loaded[rag_show_idx]
        end
    end
    @onbutton nav_random begin
        @info "> Nav to random item"
        if selected_page == "conversations"
            isempty(files_loaded) && return
            idx = rand(0:(length(files_show) - 1))
            Base.run(__model__, "this.scrollToElement('convo_$(idx)')")
        elseif selected_page == "rag"
            isempty(rag_loaded) && return
            rag_show_idx = rand(1:(length(rag_loaded)))
            rag_show = rag_loaded[rag_show_idx]
        end
    end
end
# Required for the uploader component
@client_data begin
    channel_ = ""
end
# Required for the JS events
@mounted begin
    raw"""
    window.addEventListener('scroll', this.checkElementsInView);
    this.checkElementsInView();
    """
end
@methods begin
    raw"""
    snakeCaseToTitleCase(str) {
        return str
            .split('_')
            .map(word => {
            if (word.length <= 2) {
                return word.toUpperCase();
            } else {
                return word.charAt(0).toUpperCase() + word.slice(1);
            }
            })
            .join(' ');
    },
    scrollToElement (id) {
        const el = document.getElementById(id)
        if (!el) {
          console.error(`Element with ID ${id} not found`);
          return;
        }
        const target = Quasar.scroll.getScrollTarget(el)
        const offset = el.offsetTop
        const duration = 1000
        Quasar.scroll.setVerticalScrollPosition(target, offset, duration)
      },
      isInView(element) {
        const rect = element.getBoundingClientRect();
        const windowHeight = window.innerHeight || document.documentElement.clientHeight;

        return (
          rect.top <= windowHeight &&
          rect.bottom >= 0
        );
      },
      checkElementsInView() {
        const elements = document.querySelectorAll('[id*="conv"]');
        elements.forEach((element) => {
          if (this.isInView(element)) {
            console.log(`Element with ID ${element.id} is in view`);
          }
        });
      },
      scrollToElementPrevious() {
        const convoElements = document.querySelectorAll('[id*="convo_"]');
        let currentIndex = -1;
        convoElements.forEach((element, index) => {
          if (this.isInView(element)) {
            currentIndex = index;
          }
        });
        if (currentIndex > 0) {
          this.scrollToElement(convoElements[currentIndex - 1].id);
        }
      },
      scrollToElementNext() {
        const convoElements = document.querySelectorAll('[id*="convo_"]');
        let currentIndex = -1;
        convoElements.forEach((element, index) => {
          if (this.isInView(element)) {
            currentIndex = index;
          }
        });
        if (currentIndex >= 0 && currentIndex < convoElements.length - 1) {
          this.scrollToElement(convoElements[currentIndex + 1].id);
        }
      },
    filterFn (val, update) {
        if (val === '') {
            update(() => {
            // reset to full option list
            this.chat_template_options = this.chat_template_options_all
            })
            return
        }

        update(() => {
            // filter down based on user provided input
            const needle = val.toLowerCase()
            this.chat_template_options = this.chat_template_options_all.filter(v => v.toLowerCase().indexOf(needle) > -1)
        })
        },
    filterFnAuto (val, update) {
        if (val === '') {
            update(() => {
            // reset to full option list
            this.chat_auto_template_options = this.chat_auto_template_options_all
            })
            return
        }

        update(() => {
            // filter down based on user provided input
            const needle = val.toLowerCase()
            this.chat_auto_template_options = this.chat_auto_template_options_all.filter(v => v.toLowerCase().indexOf(needle) > -1)
        })
        },
    copyToClipboard: function(index) {
        console.log(index);
        const str = this.conv_displayed[index].content; // extract the content of the element in position `index`
        const el = document.createElement('textarea');  // Create a <textarea> element
        el.value = str;                                 // Set its value to the string that you want copied
        el.setAttribute('readonly', '');                // Make it readonly to be tamper-proof
        el.style.position = 'absolute';                 
        el.style.left = '-9999px';                      // Move outside the screen to make it invisible
        document.body.appendChild(el);                  // Append the <textarea> element to the HTML document
        el.select();                                    // Select the <textarea> content
        document.execCommand('copy');                   // Copy - only works as a result of a user action (e.g. click events)
        document.body.removeChild(el);                  // Remove the <textarea> element
    }
    """
end

route("/", named = :home) do
    model = @init()
    page(model, ui()) |> html
end
end # end of module
