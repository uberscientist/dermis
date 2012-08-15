define "dermis", (jade, View) ->
  getBaseUrl = (url) -> (if url is '/' then 'index' else /\/(.*?)\//.exec(url)?[1] or /\/(.*)/.exec(url)?[1])

  dermis =
    init: (args...) -> rooter.init args...

    route: (url, service, view) ->
      base = getBaseUrl url
      service ?= "routes/#{base}"
      view ?= "templates/#{base}"
      setup = (rtobj) ->
        console.log "calling route #{base}"
        require [service, view], (srv,tmpl) ->
          if typeof srv is 'function'
            srv rtobj, tmpl
          else
            srv.setup rtobj, tmpl

      teardown = (cb) ->
        require [service], (srv) ->
          if typeof srv is 'function'
            #i.e. service has no teardown
            cb()
          else
            srv.teardown(cb)

      rooter.route url, setup, teardown
      return

    before: (urls, filters) ->
      for url in urls
        for filter in filters
          rooter.addBeforeFilter url, filter

  return dermis
