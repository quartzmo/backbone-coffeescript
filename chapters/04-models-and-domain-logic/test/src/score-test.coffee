describe 'Models and Domain Logic', ->

  describe "Backbone.Model", ->

    before ->
      @score = new Backbone.Model points: 0

    describe "get", ->

      it "should have initial value for attribute 'points'", ->

        @score.get('points').should.equal 0

    describe "set", ->

      it "should return set value for attribute 'points'", ->

        @score.set 'points', 1

        @score.get('points').should.equal 1

  describe "Score", ->

    before ->
      @score = new Score

    describe "increment", ->

      it "should increment 'points' by 1 for each call to increment", ->

        @score.get('points').should.equal 0

        @score.increment().increment() # chaining

        @score.get('points').should.equal 2

    describe "validate", ->

      it "should return false for isValid when 'points' is less than 0", ->

        @score.set 'points', -1  # not allowed

        @score.isValid().should.be.false

  describe "Backbone.Model", ->

    before ->
      @model1 = new Backbone.Model
      @model2 = new Backbone.Model

      @model2.cid = @model1.cid

    describe "equals", ->

      it "should not determine Model identity", ->

        @model1.cid.should.equal @model2.cid

    describe "cid", ->

      it "should determine Model identity", ->

        @model1.cid.should.equal @model2.cid

  describe "Score", ->

    describe "url", ->

      it "should include Model id in path", ->

        score = new Score id: '5'

        score.url().should.equal '/api/practice/scores/5'

    # todo: Persistence

    describe "toJSON", ->

      it "should serialize with a root 'score' property", ->

        score = new Score id: "987654321", points: 25

        json = score.toJSON()
        json.should.have.property "score"
        json.score.should.have.property "id", "987654321"
        json.score.should.have.property "points", 25

    describe "parse", ->

      it "should parse from JSON with a root 'score' property", ->

        json = { "score": { "id": "987654321", "points": 25 } }

        options = parse: true
        score = new Score json, options   # Calls parse internally

        score.get('id').should.equal "987654321"
        score.get('points').should.equal 25

    # todo: Events

  describe "Backbone.Model", ->

    describe "freestyle", ->

      it "should support isNew, urlRoot, id, unset, has, escape, clear, attributes", ->

        message = new Backbone.Model subject: "I <3 Backbone.js", body: "All the way!"

        message.isNew().should.be.true

        message.urlRoot = "/phony"

        message.id = "a1"

        message.isNew().should.be.false

        message.url().should.equal "/phony/a1"

        message.unset('body')

        message.has('body').should.be.false

        message.escape('subject').should.equal "I &lt;3 Backbone.js"

        message.clear()

        message.attributes.should.be.empty


