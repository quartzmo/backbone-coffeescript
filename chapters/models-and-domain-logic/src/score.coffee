root = this

root.Score = Backbone.Model.extend

  urlRoot: '/api/practice/scores'

  defaults:
    points: 0

  increment: ->
    @set 'points', @get('points') + 1
    this

  validate: (attrs, options) ->
    if attrs.points < 0
      "'points' cannot be less than 0."

  toJSON: ->
    "score": _.clone(@attributes)

  parse: (response) ->
    response.score