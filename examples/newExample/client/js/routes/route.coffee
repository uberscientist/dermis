define [], () ->
  (args, templ) ->
    $('#content').html templ input: args
