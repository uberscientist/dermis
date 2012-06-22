define "dermis/View", ["dermis/EventEmitter"], (EventEmitter) ->
  class View extends EventEmitter
    constructor: (@_render) ->
    render: (obj) =>
      @emit 'prerender', obj
      src = @_render obj
      @emit 'postrender', obj, src
      return @

    # Sugar
    hide: (selector) =>
      @once 'rendered', (select=selector) =>
        $(select).hide()
        @emit 'hidden', select
      return @

    prepend: (selector) =>
      @once 'postrender', (obj, src) =>
        $(selector).prepend src
        @emit 'rendered', selector, obj, src
      return @

    append: (selector) =>
      @once 'postrender', (obj, src) =>
        $(selector).append src
        @emit 'rendered', selector, obj, src
      return @

    html: (selector) =>
      @once 'postrender', (obj, src) =>
        $(selector).html src
        @emit 'rendered', selector, obj, src
      return @
    target: View::html
    replace: View::html

    fadeIn: (selector, easing="slow") =>
      @hide selector
      @once 'rendered', (select=selector) =>
        $(select).fadeIn easing, =>
          @emit 'fadeIn', select
      return @

  return View