define ["dermis", "beforeFilters/answerMustBe42", "beforeFilters/printWheeee"], (dermis, answerMustBe42, printWheeee) ->

  dermis.route '/wrong'
  dermis.route '/route/:answer'

  dermis.before ['/route/:answer'], [answerMustBe42, printWheeee]
  dermis.init()
