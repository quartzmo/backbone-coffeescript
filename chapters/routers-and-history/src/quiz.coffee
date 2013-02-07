root = this
Solutions = Backbone.Collection.extend

  url: '/api/practice/solutions'

ChoiceShowView = Backbone.View.extend

  tagName: 'label'
  className: 'radio'
  template: JST['choices/show']

  render: ->
    @$el.html "<input type=\"radio\" name=\"choices\" value=\"#{ @model.id }\">"
    @$el.append @model.escape 'body'
    this

ChoicesIndexView = Backbone.View.extend

  className: 'controls well'

  render: ->
    _(@collection.where(exercise_id: @model.id)).forEach (choice) =>
      @$el.append new ChoiceShowView(model: choice).render().el
    this

ExerciseShowView = Backbone.View.extend

  className: 'control-group well quiz'
  template: JST['exercises/show']
  attributes:
    style: 'min-height: 320px;'

  events:
    "click input[type='submit']": 'submit'

  initialize: (options) ->
    @choices = options.choices
    @solutions = options.solutions
    @next = options.next

  render: ->
    @$el.html @template(exercise: @model, next: @next)
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
        console.log "Server error: #{response.status} #{response.statusText} #{response.responseText}"

    @solutions.create exercise_id: @model.id, choice_id: choiceId, options

root.Quiz = Backbone.Router.extend

  routes:
    'exercises/:id':  'show'

  initialize: (options) ->
    @exercises = options.exercises
    @choices = options.choices
    @solutions = new Solutions()

  show: (id) ->
    exercise = @exercises.get id
    view = new ExerciseShowView
      model: exercise
      next: @exercises.at(@exercises.indexOf(exercise) + 1)
      choices: @choices
      solutions: @solutions
    $('.modal-content').html view.render().el
