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

  describe "Backbone.View", ->

    describe "el", ->

      it "should return an unattached div by default", ->

        view = new Backbone.View

        view.el.tagName.should.equal 'DIV'
        expect(view.el.parentElement).to.be.null

      it "should return an element matching provided configuration", ->

        view = new Backbone.View

          id: 'choice-1'
          tagName: 'li'
          className: 'choice'

          attributes:
            title: 'Choice 1'
            'data-my-flag': true

        view.$el.attr('id').should.equal 'choice-1'
        view.$el.is('li').should.be.true
        view.$el.hasClass('choice').should.be.true

        view.$el.attr('title').should.equal 'Choice 1'
        view.$el.data('my-flag').should.be.true

  describe "ChoiceShowView", ->

    describe "render", ->

      it "should use the correct template and the provided model", ->

        choice = new Backbone.Model id: "1", body: "None of the above."

        view = new ChoiceShowView model: choice

        view.render()
        view.$el.find("input").first().attr('name').should.equal "choices"
        view.$el.text().should.equal "None of the above."

  describe "ChoicesIndexView", ->

    describe "render", ->

      it "should use the correct template and the provided collection", ->

        exercise = @exercises.at(0)

        view = new ChoicesIndexView model: exercise, collection: @choices

        view.render().$el.find("label").first().text().should.equal "Brendan Eich"

  describe "ExercisesIndexView", ->

    describe "render", ->

      it "should use the correct template and the provided collection", ->

        view = new ExercisesIndexView
          collection: @exercises
          choices: @choices
          solutions: new Solutions()

        view.render()

        view.$el.find("label").first().text().should.equal "Who created Backbone?"
        view.$el.find("label").last().text().should.equal "Douglas Crockford"

  describe "SolutionsView", ->

    beforeEach ->

      @solutions = new Solutions [{correct: true}, {correct: true}, {correct: false}]
      @view = new SolutionsView collection: @solutions

      @view.render()


    describe "render", ->

      it "should use the correct template and the provided collection", ->

        @view.el.innerHTML.should.equal "<button class=\"close\">×</button>Correct: 2/3"


    describe "collection event", ->

      it "should re-render itself when its collection changes", ->

        @solutions.add correct: false

        @view.el.innerHTML.should.equal "<button class=\"close\">×</button>Correct: 2/4"
