define "dermis", (jade, View) ->
  getBaseUrl = (longUrl) ->
    queryIndex = longUrl.indexOf '?'
    url = (if queryIndex is -1 then longUrl else longUrl.slice 0, queryIndex)
    (if url is '/' then 'index' else /\/(.*?)\//.exec(url)?[1] or /\/(.*)/.exec(url)?[1])

  parseQueryString = (query) ->
    queryParams = {}
    match = undefined
    pl = /\+/g # Regex for replacing addition symbol with a space
    search = /([^&=]+)=?([^&]*)/g
    decode = (s) ->
      decodeURIComponent s.replace(pl, " ")

    queryParams[decode(match[1])] = decode(match[2]) while match = search.exec(query)
    return queryParams

  dermis =
    init: (args...) -> rooter.init args...

    route: (url, service, view) ->
      base = getBaseUrl url
      service ?= "routes/#{base}"
      view ?= "templates/#{base}"
      setup = (routeArguments, queryString) ->
        require [service, view], (srv,tmpl) ->
          if typeof srv is 'function'
            srv routeArguments, tmpl, parseQueryString queryString
          else
            srv.setup routeArguments, tmpl, parseQueryString queryString

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
