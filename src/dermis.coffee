define "dermis", (jade, View) ->
  getBaseUrl = (url) -> (if url is '/' then 'index' else /\/(.*?)\//.exec(url)?[1] or /\/(.*)/.exec(url)?[1])

  dermis =
    init: (args...) -> rooter.init args...

    route: (url, service, view) ->
      base = getBaseUrl url
      service ?= "routes/#{base}"
      view ?= "templates/#{base}"
      rooter.route url, (rtobj) ->
        require [service, view], (srv,tmpl) ->
          srv rtobj, tmpl
      return

    before: (urls, filters) ->
      for url in urls
        for filter in filters
          rooter.addBeforeFilter url, filter

  return dermis
