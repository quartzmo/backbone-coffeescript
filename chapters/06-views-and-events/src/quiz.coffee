# Code examples that contain assertions are located at ../test/src/*.coffee

root = this

root.ChoiceShowView = Backbone.View.extend

  tagName: 'label'
  className: 'radio'
  template: JST['choices/show']

  render: ->
    @$el.html @template(choice: @model)
    this


root.ChoicesIndexView = Backbone.View.extend

  className: 'controls well'

  render: ->
    _(@collection.where(exercise_id: @model.id)).forEach (choice) =>
      @$el.append new ChoiceShowView(model: choice).render().el
    this


root.Solutions = Backbone.Collection.extend

  url: '/api/practice/solutions'


root.ExercisesIndexView = Backbone.View.extend

  className: 'control-group well'
  template: JST['exercises/index']

  events:
    "click input[type='submit']": 'submit'
    "click input[value='Next']": 'render'
    "click input[value='Done']": 'undelegateEvents'

  initialize: (options) ->
    @choices = options.choices
    @solutions = options.solutions
    @index = 0

  render: ->
    @model = @collection.at @index
    if @index == (@collection.length - 1) then @index = 0 else @index++
    @$el.html @template(exercise: @model)
    @$('.control-label').after new ChoicesIndexView(model: @model, collection: @choices).render().el
    this


  submit: ->
    choiceId = @$("input[name='choices']:checked").val()

    return @$('.notice').text "Please select an answer." unless choiceId

    @$("input[type='submit']").attr 'disabled', 'disabled'

    options =
      success: (solution) ->
        @$('.notice').text (if solution.get 'correct' then 'Correct' else 'Incorrect')
      error: (solution, response) ->
        editor.log "Server error: #{response.status} #{response.statusText} #{response.responseText}"

    @solutions.create exercise_id: @model.id, choice_id: choiceId, options


root.SolutionsView = Backbone.View.extend

  className: 'alert alert-info'

  attributes:
    style: "position: fixed; top: 48px; right: 12px;"

  events:
    'click button.close': 'destroy'

  initialize: (options) ->
    @collection.on 'all', @render, this

  render: ->
    @$el.html "<button class='close'>×</button>"
    @$el.append "Correct: #{@collection.where(correct: true).length}/#{@collection.length}"
    this

  destroy: ->
    @collection.off null, null, this
    @$el.remove()