// Generated by CoffeeScript 1.6.1
(function() {

  describe('Collections and Sync', function() {
    before(function() {
      return this.json = {
        "choices": [
          {
            "id": 1,
            "exercise_id": 1,
            "position": 1,
            "body": "Model"
          }, {
            "id": 2,
            "exercise_id": 1,
            "position": 2,
            "body": "View"
          }, {
            "id": 3,
            "exercise_id": 1,
            "position": 3,
            "body": "Controller"
          }, {
            "id": 4,
            "exercise_id": 1,
            "position": 4,
            "body": "None of the above"
          }, {
            "id": 5,
            "exercise_id": 2,
            "position": 1,
            "body": "Underscore"
          }, {
            "id": 6,
            "exercise_id": 2,
            "position": 2,
            "body": "Handlebars"
          }, {
            "id": 8,
            "exercise_id": 2,
            "position": 4,
            "body": "All of the above"
          }
        ]
      };
    });
    describe("Backbone.Collection", function() {
      return describe("add", function() {
        it("should insert an instance of Backbone.Model", function() {
          var collection;
          collection = new Backbone.Collection;
          collection.add({});
          collection.length.should.equal(1);
          return collection.at(0).should.be.an.instanceOf(Backbone.Model);
        });
        it("should insert two logically equivalent instances", function() {
          var collection;
          collection = new Backbone.Collection;
          collection.add({
            email: 'fred@example.com'
          });
          collection.add(new Backbone.Model({
            email: 'fred@example.com'
          }));
          return collection.length.should.equal(2);
        });
        return it("should not insert a duplicate entity based on id", function() {
          var collection;
          collection = new Backbone.Collection;
          collection.add({
            id: 1,
            email: 'fred@example.com',
            name: 'Fred'
          });
          collection.add({
            id: 1,
            email: 'fred@example.com',
            name: 'Frederick'
          }, {
            merge: true
          });
          collection.length.should.equal(1);
          return collection.at(0).get('name').should.equal('Frederick');
        });
      });
    });
    describe("Scores", function() {
      return describe("add", function() {
        return it("should create an instance of Score", function() {
          var scores;
          scores = new Scores;
          scores.add({});
          scores.at(0).should.be.an.instanceOf(Score);
          return scores.at(0).get('points').should.equal(0);
        });
      });
    });
    describe("Backbone.Collection", function() {
      describe("push", function() {
        var collection, popped, pushed;
        collection = new Backbone.Collection;
        pushed = collection.push({});
        collection.length.should.equal(1);
        popped = collection.pop();
        popped.should.equal(pushed);
        return collection.isEmpty().should.be["true"];
      });
      return describe("remove", function() {
        var collection;
        collection = new Backbone.Collection;
        collection.add({});
        collection.remove(collection.last());
        return collection.isEmpty().should.be["true"];
      });
    });
    describe("Backbone.Collection", function() {
      beforeEach(function() {
        return this.collection = new Backbone.Collection(this.json.choices);
      });
      describe("initialize", function() {
        return it("should create instances of Backbone.Model from JSON", function() {
          return this.collection.length.should.equal(7);
        });
      });
      return describe("at", function() {
        return it("should return models in the same order as the original JSON", function() {
          var first;
          first = this.collection.at(0);
          first.get('id').should.equal(1);
          first.get('exercise_id').should.equal(1);
          return first.get('position').should.equal(1);
        });
      });
    });
    describe("Backbone.Collection", function() {
      describe("add", function() {
        return it("should add all models from an array", function() {
          var collection;
          collection = new Backbone.Collection([
            {
              id: 1
            }, {
              id: 2
            }
          ]);
          collection.add([
            {
              id: 3
            }, {
              id: 4
            }
          ]);
          return collection.length.should.equal(4);
        });
      });
      describe("reset", function() {
        return it("should replace the existing models", function() {
          var collection;
          collection = new Backbone.Collection([
            {
              id: 1
            }, {
              id: 2
            }
          ]);
          collection.reset();
          collection.length.should.equal(0);
          collection.reset([
            {
              id: 2
            }, {
              id: 3
            }
          ]);
          return collection.length.should.equal(2);
        });
      });
      return describe("set", function() {
        return it("should smart-update the existing model set", function() {
          var collection, keeper;
          keeper = new Backbone.Model({
            id: 2,
            position: 2
          });
          collection = new Backbone.Collection([
            {
              id: 1,
              position: 1
            }, keeper
          ]);
          collection.set([
            {
              id: 2,
              position: 1
            }, {
              id: 3,
              position: 3
            }
          ]);
          collection.first().id.should.equal(2);
          collection.first().get('position').should.equal(1);
          return collection.first().should.equal(keeper);
        });
      });
    });
    return describe("Backbone.Collection", function() {
      beforeEach(function() {
        return this.collection = new Backbone.Collection(this.json.choices);
      });
      describe("comparator (model)", function() {
        return it("should enable custom ordering by a single attribute", function() {
          this.collection.comparator = function(model) {
            return model.get('position');
          };
          this.collection.add({
            exercise_id: 2,
            position: 3,
            body: "JSP"
          });
          return this.collection.pluck('position').should.eql([1, 1, 2, 2, 3, 3, 4, 4]);
        });
      });
      describe("comparator (a, b)", function() {
        return it("should enable custom ordering by an arbitrary comparison method", function() {
          this.collection.comparator = function(a, b) {
            if (a.get('exercise_id') === b.get('exercise_id')) {
              return a.get('position') - b.get('position');
            } else {
              return a.get('exercise_id') - b.get('exercise_id');
            }
          };
          this.collection.add({
            exercise_id: 2,
            position: 3,
            body: "JSP"
          });
          this.collection.pluck('exercise_id').should.eql([1, 1, 1, 1, 2, 2, 2, 2]);
          return this.collection.pluck('position').should.eql([1, 2, 3, 4, 1, 2, 3, 4]);
        });
      });
      describe("where", function() {
        return it("should return models matched by a simple query on attributes", function() {
          var choices;
          choices = this.collection.where({
            exercise_id: 2,
            position: 4
          });
          choices.should.be.an.instanceOf(Array);
          choices.length.should.equal(1);
          return choices[0].get('body').should.equal("All of the above");
        });
      });
      return describe("filter", function() {
        return it("should return models for which filter expression is truthy", function() {
          var evens;
          evens = this.collection.filter(function(model) {
            return model.get('position') % 2 === 0;
          });
          return _.map(evens, function(model) {
            return model.get('position');
          }).should.eql([2, 4, 2, 4]);
        });
      });
    });
  });

}).call(this);