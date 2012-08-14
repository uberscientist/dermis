define [], () ->
  setup:
    (args, templ) ->
      console.log "args", args
      $('#content').html templ input: args
  teardown:
    (cb) ->
      console.log "I'll miss you!"
      cb()
