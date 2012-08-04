define "dermis", (jade, View) ->
  dermis =
    init: (args...) -> rooter.init args...

    route: (url, service, view) ->
      base = (if url is '/' then 'index' else /\/(.*?)\//.exec(url)?[1] or /\/(.*)/.exec(url)?[1])
      service ?= "routes/#{base}"
      view ?= "templates/#{base}"
      rooter.route url, (rtobj) ->
        require [service, view], (srv,tmpl) -> 
          srv rtobj, tmpl
      return
  return dermis