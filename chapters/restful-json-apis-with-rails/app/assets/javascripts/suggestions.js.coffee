window.Feedback or= {}

Feedback.Suggestions = Backbone.Collection.extend
  url: '/suggestions'

Feedback.IndexView = Backbone.View.extend

  template: JST['templates/suggestions/index']

  render: ->
    @$el.html @template(this)
    this