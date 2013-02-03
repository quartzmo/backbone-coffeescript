
describe 'Quick Tour', ->

  describe "Backbone.Model", ->

    before ->
      @suggestion = new Backbone.Model subject: "Backbone + CoffeeScript"

    describe "get", ->

      it "should have initial value for attribute 'subject'", ->
        @suggestion.get('subject').should.equal "Backbone + CoffeeScript"

    describe "set", ->

      it "should return set value for attribute 'subject'", ->

        @suggestion.set 'message', "What the world needs now..."

        @suggestion.get('message').should.equal "What the world needs now..."


  describe "Suggestions", ->

    beforeEach ->
      @suggestions = new Suggestions

    describe "url", ->

      it "should return '/api/feedback/suggestions' for new instance", ->
        @suggestions.url.should.equal "/api/feedback/suggestions"


  describe "ShowView", ->

    beforeEach ->
      suggestion = new Backbone.Model subject: "Hello", message: "I am a Model."
      @showView = new ShowView model: suggestion

    describe "el", ->

      it "should return a 'div' element", ->
        @showView.el.tagName.should.equal "DIV"

    describe "render", ->

      it "should include the subject from the model", ->
        @showView.render().el.outerHTML.should.match /Hello/

      it "should include the message from the model", ->
        @showView.render().el.outerHTML.should.match /I am a Model./


  describe "IndexView", ->

    beforeEach ->
      @indexView = new IndexView collection: new Backbone.Collection([new Backbone.Model(subject: "Hello", message: "I am a Model.")])

    describe "el", ->

      it "should return a 'div' element", ->
        @indexView.el.tagName.should.equal "DIV"

    describe "render", ->

      it "should include the subject from the model", ->
        @indexView.render().el.outerHTML.should.match /Hello/

      it "should not include the message from the model", ->
        @indexView.render().el.outerHTML.should.not.match /I am a Model./


  describe "NewView", ->

    beforeEach ->
      @newView = new NewView collection: new Backbone.Collection

    describe "el", ->

      it "should return a 'div' element", ->
        @newView.el.tagName.should.equal "DIV"

    describe "render", ->

      it "should accept the subject for the new model", ->
        @newView.render().el.outerHTML.should.match /subject/

      it "should accept the message for the new model", ->
        @newView.render().el.outerHTML.should.match /message/



  describe "App", ->

    beforeEach ->
      @suggestions = new Suggestions
      sinon.stub(@suggestions, "fetch").yieldsTo('success', @suggestions)

      @app = new App(@suggestions)
      Backbone.history.stop()
      Backbone.history.start()

    describe "index", ->

      it "should fetch models", ->
        @app.index()