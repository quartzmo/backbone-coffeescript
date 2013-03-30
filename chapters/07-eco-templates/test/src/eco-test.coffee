describe 'Eco Templates', ->

  before ->

    @exercises = new Backbone.Collection(
      [
        { id: 101, body: "Who created Backbone?" }
        { id: 102, body: "Backbone implements which architectural pattern?" }
      ]
    )

  describe "eco", ->

    describe "render literal", ->

      it "should return literal content unchanged", ->

        template = '<strong>Backbone + CoffeeScript</strong>'

        output = eco.render(template)

        output.should.equal template

    describe "render model", ->

      it "should interpolate model content", ->

        template = "<label><%= @exercise.get 'body' %></label>"

        exercise = @exercises.at 0

        output = eco.render(template, exercise: exercise)

        output.should.equal "<label>Who created Backbone?</label>"

    describe "compile", ->

      it "should return a reusable function", ->

        template = "<label><%= @exercise.get 'body' %></label>"

        showExercise = eco.compile template

        for exercise in @exercises.shuffle()
          do (exercise) ->
            output = showExercise(exercise: exercise)
            output.should.equal "<label>#{ exercise.get('body') }</label>"

    describe "compile heredoc", ->

      it "should return a reusable function", ->

        showExercise = eco.compile '''
          <div class="well">
            <label><%= @exercise.get 'body' %></label>
            <div class="controls well">
              <label class="radio">
                <input type="radio" name="choices" value="1">
                Choice 1
              </label>
            </div>
          </div>
        '''

        exercise = @exercises.at 0

        output = showExercise(exercise: exercise)
        output.should.match /Who created Backbone?/

  describe "underscore", ->

    describe "JavaScript existential", ->

      it "should handle a missing context variable", ->

        JST['underscore/exercises/index'] = _.template($('#underscore-exercises-index').html());

        output = JST['underscore/exercises/index']({})

        output.should.match /The length of the quiz, if it exists:/

  describe "eco", ->

    describe "existential", ->

      it "should handle a missing context variable", ->

        output = JST['exercises/index']({})

        output.should.match /The length of the quiz, if it exists:/


    describe "conditional", ->

      it "should return the correct content based on model state", ->

        solution = new Backbone.Model correct: false

        JST['solutions/show'](solution: solution).should.match /Your answer was incorrect./

    describe "ad-hoc helper", ->

      it "should modify context data", ->

        context =
          model: new Backbone.Model(name: 'Fred')
          loud: (s) -> s.toUpperCase()

        template = "Hi there, <%= @loud @model.get('name') %>."

        eco.render(template, context).should.equal "Hi there, FRED."

    describe "global namespaced helper", ->

      it "should modify context data", ->

        window.ViewHelpers or= {}

        window.ViewHelpers.loud = (s) -> s.toUpperCase()

        context = $.extend { model: new Backbone.Model(name: 'Fred') }, window.ViewHelpers

        template = "Hi there, <%= @loud @model.get('name') %>."

        eco.render(template, context).should.equal "Hi there, FRED."

  describe "moment", ->

    describe "timeago helper", ->

      it "should modify context data", ->

        _.mixin timeago: (date, parseFormat) -> moment(date, parseFormat).fromNow()

        context = date: new Date(2010, 9, 30)

        template = "The first Backbone.js commit was <%= _.timeago @date %>."

        eco.render(template, context).should.equal "The first Backbone.js commit was 2 years ago."

  describe "accounting", ->

    describe "formatMoney", ->

      it "should modify context data", ->

        data =
          person:
            name: 'Fred'
            # more attributes . . .
          debt: 15000

        context = $.extend {}, window.accounting, data

        template = 'Hi there, <%= @person.name %>.\nI know, I still owe you <%= @formatMoney @debt %>!'

        eco.render(template, context).should.equal 'Hi there, Fred.\nI know, I still owe you $15,000.00!'

  describe "underscore.string", ->

    describe "capitalize and toSentence", ->

      it "should modify context data", ->

        context =
          words: ["good", "bad", "ugly"]
          capitalize: _.str.capitalize
          toSentence: _.str.toSentence
          movieTitleize: (array) ->
            @toSentence("the " + @capitalize(s) for s in array)

        template = 'Here come <%= @movieTitleize @words %>.'

        output = eco.render(template, context)

        output.should.equal "Here come the Good, the Bad and the Ugly."

  describe "eco", ->

    describe "safe and escape helpers", ->

      it "should be available by default", ->

        template = 'I am Eco. My built-in helpers are <%= @safe (x for x of @).join(" &amp; ") %>.'
        eco.render(template).should.equal 'I am Eco. My built-in helpers are safe &amp; escape.'

    describe "formFor", ->

      it "should utilize captured blocks", ->

        window.ViewHelpers or= {}

        window.ViewHelpers.formFor = (model, yield_to) ->
          form =
            textField: (attribute) =>
              name  = @escape attribute
              value = @escape model.get(attribute)
              @safe "<input type='text' name='#{name}' value='#{value}'>"

          url  = "/projects/#{model.id}"
          body = yield_to form
          @safe "<form action='#{url}' method='post'>#{body}</form>"

        context = $.extend { project: new Backbone.Model(id: 1, name: "Mobile app") }, window.ViewHelpers

        output = JST['exercises/new'](context)

        $(output).find('input').first().val().should.equal "Mobile app"


