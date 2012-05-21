define "dermis", ["jade"], (jade) ->
  route = (url, service, view) ->
    base = (if url is '/' then 'index' else /\/(.*?)\//.exec(url)[1])
    service ?= "routes/#{base}"
    view ?= "templates/#{base}"
    route = {}
    rooter.route url, (a) -> require [service, view], (s,t) -> s a,t

  init: rooter.init
  route: route