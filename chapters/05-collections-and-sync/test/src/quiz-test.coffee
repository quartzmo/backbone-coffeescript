describe 'Collections and Sync', ->

  before ->

    @json = {

      "choices": [

        { "exercise_id": 1, "position": 1, "body": "Model"              },
        { "exercise_id": 1, "position": 2, "body": "View"               },
        { "exercise_id": 1, "position": 3, "body": "Controller"         },
        { "exercise_id": 1, "position": 4, "body": "None of the above"  },
        { "exercise_id": 2, "position": 1, "body": "Underscore"         },
        { "exercise_id": 2, "position": 2, "body": "Handlebars"         },
        { "exercise_id": 2, "position": 4, "body": "All of the above"   }

      ]
    }

  describe "Backbone.Collection", ->

    describe "add", ->

      it "should create an instance of Backbone.Model", ->

        collection = new Backbone.Collection

        collection.add {}

        collection.length.should.equal 1
        collection.at(0).should.be.an.instanceOf Backbone.Model

  describe "Scores", ->

    describe "add", ->

      it "should create an instance of Score", ->

        scores = new Scores

        scores.add {}

        scores.at(0).should.be.an.instanceOf Score
        scores.at(0).get('points').should.equal 0

  describe "Backbone.Collection", ->

    beforeEach ->
      @collection = new Backbone.Collection @json.choices

    describe "initialize", ->

      it "should create instances of Backbone.Model from JSON", ->

        @collection.length.should.equal 7

    describe "at", ->

      it "should return models in the same order as the original JSON", ->

        first = @collection.at(0)

        first.get('exercise_id').should.equal 1
        first.get('position').should.equal 1

    describe "push", ->

      it "should return the created model", ->

        pushed = @collection.push exercise_id: 2, position: 5, body: "None of the above"

        @collection.length.should.equal 8

        popped = @collection.pop()

        popped.should.equal pushed

        @collection.length.should.equal 7

    describe "reset", ->

      it "should replace the existing models", ->

        @collection.reset()

        @collection.length.should.equal 0

        @collection.reset @json.choices

        @collection.length.should.equal 7

    describe "add", ->

      it "should add all models from an array", ->

        @collection.add [
          { exercise_id: 2, position: 3, body: "JSP" }
          { exercise_id: 2, position: 5, body: "None of the above" }
        ]

        @collection.length.should.equal 9

        @collection.at(6).get('position').should.equal 4
        @collection.at(7).get('position').should.equal 3
        @collection.at(8).get('position').should.equal 5

    describe "comparator (model)", ->

      it "should enable custom ordering by a single attribute", ->

        @collection.comparator = (model) -> model.get('position')

        @collection.add exercise_id: 2, position: 3, body: "JSP"
        @collection.pluck('position').should.eql [1,1,2,2,3,3,4,4]

    describe "comparator (a, b)", ->

      it "should enable custom ordering by an arbitrary comparison method", ->

        @collection.comparator = (a, b) ->
          if a.get('exercise_id') == b.get('exercise_id')
            a.get('position') - b.get('position')
          else
            a.get('exercise_id') - b.get('exercise_id')

        @collection.add exercise_id: 2, position: 3, body: "JSP"

        @collection.pluck('exercise_id').should.eql [1,1,1,1,2,2,2,2]

        @collection.pluck('position').should.eql [1,2,3,4,1,2,3,4]

    describe "where", ->

      it "should return models matched by a simple query on attributes", ->

        choices = @collection.where exercise_id: 2, position: 4

        choices.should.be.an.instanceOf Array
        choices.length.should.equal 1

        choices[0].get('body').should.equal "All of the above"

    describe "filter", ->

      it "should return models for which filter expression is truthy", ->

        evens = @collection.filter (model) ->
          model.get('position') % 2 is 0

        _.map(evens, (model) -> model.get('position')).should.eql [2, 4, 2, 4]

    # todo: Events
    # todo: Persistence


