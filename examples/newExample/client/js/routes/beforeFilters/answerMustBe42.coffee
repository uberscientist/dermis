define [], ->
  (args, next) ->
    console.log args
    if args.answer is "42"
      next()
    else
      console.log "wrong answer"
      window.location.hash = "#/wrong"
      next "err: wrong answer"
