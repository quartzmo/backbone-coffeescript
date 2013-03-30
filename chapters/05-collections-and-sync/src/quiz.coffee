# Code examples that contain assertions are located at ../test/src/*.coffee

root = this

root.Score = Backbone.Model.extend

  defaults:
    points: 0

root.Scores = Backbone.Collection.extend

  model: Score
