define "dermis", (jade, View) ->
  getBaseUrl = (url) -> (if url is '/' then 'index' else /\/(.*?)\//.exec(url)?[1] or /\/(.*)/.exec(url)?[1])

  dermis =
    init: (args...) -> rooter.init args...

    route: (url, service, view) ->
      base = getBaseUrl url
      service ?= "routes/#{base}"
      view ?= "templates/#{base}"
      setup = (rtobj) ->
        require [service, view], (srv,tmpl) ->
          if typeof srv is 'function'
            srv rtobj, tmpl
          else
            srv.setup rtobj, tmpl

      teardown = (cb) ->
        require [service], (srv) ->
          srv.teardown(cb) unless typeof srv is 'function'

      rooter.route url, setup, teardown
      return

    before: (urls, filters) ->
      for url in urls
        for filter in filters
          rooter.addBeforeFilter url, filter

  return dermis
