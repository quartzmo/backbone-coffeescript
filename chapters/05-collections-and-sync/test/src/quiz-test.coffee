describe 'Collections and Sync', ->

  before ->

    @json = {

      "choices": [

        { "id": 1, "exercise_id": 1, "position": 1, "body": "Model"              },
        { "id": 2, "exercise_id": 1, "position": 2, "body": "View"               },
        { "id": 3, "exercise_id": 1, "position": 3, "body": "Controller"         },
        { "id": 4, "exercise_id": 1, "position": 4, "body": "None of the above"  },
        { "id": 5, "exercise_id": 2, "position": 1, "body": "Underscore"         },
        { "id": 6, "exercise_id": 2, "position": 2, "body": "Handlebars"         },
        { "id": 8, "exercise_id": 2, "position": 4, "body": "All of the above"   }

      ]
    }

  describe "Backbone.Collection", ->

    describe "add", ->

      it "should insert an instance of Backbone.Model", ->

        collection = new Backbone.Collection

        collection.add {}

        collection.length.should.equal 1
        collection.at(0).should.be.an.instanceOf Backbone.Model

      it "should insert two logically equivalent instances", ->

        collection = new Backbone.Collection

        collection.add email: 'fred@example.com'
        collection.add new Backbone.Model email: 'fred@example.com'

        collection.length.should.equal 2

      it "should not insert a duplicate entity based on id", ->

        collection = new Backbone.Collection

        collection.add id: 1, email: 'fred@example.com', name: 'Fred'
        collection.add { id: 1, email: 'fred@example.com', name: 'Frederick' }, merge: true

        collection.length.should.equal 1
        collection.at(0).get('name').should.equal 'Frederick'

  describe "Scores", ->

    describe "add", ->

      it "should create an instance of Score", ->

        scores = new Scores

        scores.add {}

        scores.at(0).should.be.an.instanceOf Score
        scores.at(0).get('points').should.equal 0

  describe "Backbone.Collection", ->

    describe "push", ->

      collection = new Backbone.Collection

      pushed = collection.push {}

      collection.length.should.equal 1

      popped = collection.pop()

      popped.should.equal pushed

      collection.isEmpty().should.be.true

    describe "remove", ->

      collection = new Backbone.Collection

      collection.add {}

      collection.remove collection.last()

      collection.isEmpty().should.be.true


  describe "Backbone.Collection", ->

    beforeEach ->
      @collection = new Backbone.Collection @json.choices

    describe "initialize", ->

      it "should create instances of Backbone.Model from JSON", ->

        @collection.length.should.equal 7

    describe "at", ->

      it "should return models in the same order as the original JSON", ->

        first = @collection.at(0)

        first.get('id').should.equal 1
        first.get('exercise_id').should.equal 1
        first.get('position').should.equal 1

  describe "Backbone.Collection", ->

    describe "add", ->

      it "should add all models from an array", ->

        collection = new Backbone.Collection [ { id: 1 }, { id: 2 } ]

        collection.add [ { id: 3 }, { id: 4 } ]

        collection.length.should.equal 4

    describe "reset", ->

      it "should replace the existing models", ->

        collection = new Backbone.Collection [ { id: 1 }, { id: 2 } ]

        collection.reset()

        collection.length.should.equal 0

        collection.reset [ { id: 2 }, { id: 3 } ]

        collection.length.should.equal 2

    describe "set", ->

      it "should smart-update the existing model set", ->

        keeper = new Backbone.Model id: 2, position: 2

        collection = new Backbone.Collection [ { id: 1, position: 1 }, keeper ]

        collection.set [ { id: 2, position: 1 }, { id: 3, position: 3 } ]

        collection.first().id.should.equal 2
        collection.first().get('position').should.equal 1

        collection.first().should.equal keeper


  describe "Backbone.Collection", ->

    beforeEach ->
      @collection = new Backbone.Collection @json.choices

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


