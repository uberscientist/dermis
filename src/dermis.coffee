define "dermis", ["jade", "dermis/View"], (jade, View) ->
  route = (url, service, view) ->
    base = (if url is '/' then 'index' else /\/(.*?)\//.exec(url)?[1] or /\/(.*)/.exec(url)?[1])
    service ?= "routes/#{base}"
    view ?= "templates/#{base}"
    route = {}
    rooter.route url, (rtobj) -> 
      require [service, view], (srv,tmpl) -> 
        srv rtobj, new View tmpl

  init: rooter.init
  route: route