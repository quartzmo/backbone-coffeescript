describe 'Views and Events', ->

  before ->

    @exercises = new Backbone.Collection(
      [
        { id: 101, body: "Who created Backbone?" }
      ]
    )

    @choices = new Backbone.Collection(
      [
        { id: 1, exercise_id: 101, body: "Brendan Eich", position: 1 }
        { id: 2, exercise_id: 101, body: "Jeremy Ashkenas", position: 2 }
        { id: 3, exercise_id: 101, body: "John Resig", position: 3 }
        { id: 4, exercise_id: 101, body: "Yehuda Katz", position: 4 }
        { id: 5, exercise_id: 101, body: "Douglas Crockford", position: 5 }
      ]
    )

  describe "Backbone.history", ->

    describe "start", ->

      it "should set the state of Backbone.History to started", ->

        Backbone.history.stop()    # Not needed in most applications

        Backbone.history.start()

        Backbone.History.started.should.be.true

    describe "navigate", ->

      it "should return an element matching provided configuration", ->

        router = new Backbone.Router

        router.route 'exercises', 'index', -> console.log "Route 'exercises' matched to 'index'."

        Backbone.history.stop()
        Backbone.history.start()

        Backbone.history.navigate 'exercises'

        window.location.hash.should.equal "#exercises"

  describe "Backbone.Router", ->

    beforeEach ->

      Backbone.history.stop()

      Backbone.history = new Backbone.History;

      @index = sinon.spy()
      @edit = sinon.spy()

      App = Backbone.Router.extend

        routes:
          'exercises':      'index'
          'exercises/edit': 'edit'

        index: @index

        edit: @edit

      new App()

      Backbone.history.start()


    describe "routes", ->

      it "should invoke index action when the path is matched", ->

        #Backbone.history.navigate 'exercises'

        @index.calledOnce.should.be.true
        @edit.notCalled.should.be.true



  describe "Backbone.history", ->

    describe "navigate", ->
      it "should replace last history entry when replace option is true", ->

        Backbone.history = new Backbone.History

        Backbone.history.stop()
        Backbone.history.start()

        Backbone.history.navigate 'one'
        Backbone.history.navigate 'two'
        Backbone.history.navigate 'three', replace: true

        window.location.hash.should.equal "#three"

  describe "Quiz", ->

    describe "navigate", ->

      it "should use the correct template and the provided model", ->

        quiz = new Quiz
          exercises: @exercises
          choices: @choices

        Backbone.history.stop()  # Not common, needed here for subsequent runs
        Backbone.history.start()  # pushState: true results in security exception when running from file.

        quiz.navigate 'exercises/101', trigger: true

        window.location.hash.should.equal "#exercises/101"
