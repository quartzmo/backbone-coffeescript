# Code examples that contain assertions are located at ../test/src/*.coffee

root = this

root.Suggestions = Backbone.Collection.extend
  url: '/api/feedback/suggestions'

root.ShowView = Backbone.View.extend

  template: '''
    <h3>
      <%= @model.get('subject') %>
    </h3>
    <p>
      <%= @model.get('message') %>
    </p>
    <a href="#" class="btn">
      Back
    </a>
  '''

  render: ->
    @$el.html eco.render(@template, model: @model)
    this

root.IndexView = Backbone.View.extend

  template: JST['suggestions/index']

  render: ->
    @$el.html @template(this)
    this

root.NewView = Backbone.View.extend

  events:
    'click #new-submit': 'create'

  template: JST['suggestions/new']

  render: ->
    @$el.html @template
    this

  create: (event) ->
    event.preventDefault()

    suggestion =
      subject: @$('#subject').val()
      message: @$('#message').val()

    options =
      wait: true
      error: (model, response) ->
        json = jQuery.parseJSON response.responseText
        @$('.alert').show().html json.errors.join('<br>')

    @collection.create suggestion, options

root.App = Backbone.Router.extend

  routes:
    '':         'index'
    'new':      'new'
    'show/:id': 'show'

  initialize: (collection) ->
    @collection = collection

    # Go to show after model in collection is saved
    @collection.on 'add', (model) =>
      @navigate "show/#{model.id}", trigger: true

    @navigate ''

  index: ->
    @collection.fetch
      success: (collection) ->
        $('.modal-content').html new IndexView(collection: collection).render().el
      error: (collection, response) ->
        throw new Error(response.status + ' ' + response.responseText)

  new: ->
    # good to create new view each time due to the timing with which dom events are initialized
    $('.modal-content').html new NewView(collection: @collection).render().el

  show: (id) ->
    suggestion = @collection.get(id)
    $('.modal-content').html new ShowView(model: suggestion).render().el
