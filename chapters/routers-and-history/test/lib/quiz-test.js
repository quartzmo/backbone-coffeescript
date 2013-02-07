(function() {

  describe('Routers and History', function() {
    before(function() {
      this.exercises = new Backbone.Collection([
        {
          id: 101,
          body: "Who created Backbone?"
        }
      ]);
      return this.choices = new Backbone.Collection([
        {
          id: 1,
          exercise_id: 101,
          body: "Brendan Eich",
          position: 1
        }, {
          id: 2,
          exercise_id: 101,
          body: "Jeremy Ashkenas",
          position: 2
        }, {
          id: 3,
          exercise_id: 101,
          body: "John Resig",
          position: 3
        }, {
          id: 4,
          exercise_id: 101,
          body: "Yehuda Katz",
          position: 4
        }, {
          id: 5,
          exercise_id: 101,
          body: "Douglas Crockford",
          position: 5
        }
      ]);
    });
    describe("Backbone.history", function() {
      describe("start", function() {
        return it("should set the state of Backbone.History to started", function() {
          Backbone.history.stop();
          Backbone.history.start();
          return Backbone.History.started.should.be["true"];
        });
      });
      return describe("navigate", function() {
        return it("should return an element matching provided configuration", function() {
          var router;
          router = new Backbone.Router;
          router.route('exercises', 'index', function() {
            return console.log("Route 'exercises' matched to 'index'.");
          });
          Backbone.history.stop();
          Backbone.history.start();
          Backbone.history.navigate('exercises');
          return window.location.hash.should.equal("#exercises");
        });
      });
    });
    describe("Backbone.Router", function() {
      beforeEach(function() {
        var App;
        Backbone.history.stop();
        Backbone.history = new Backbone.History;
        this.index = sinon.spy();
        this.edit = sinon.spy();
        App = Backbone.Router.extend({
          routes: {
            'exercises': 'index',
            'exercises/edit': 'edit'
          },
          index: this.index,
          edit: this.edit
        });
        new App();
        return Backbone.history.start();
      });
      return describe("routes", function() {
        return it("should invoke index action when the path is matched", function() {
          this.index.calledOnce.should.be["true"];
          return this.edit.notCalled.should.be["true"];
        });
      });
    });
    describe("Backbone.history", function() {
      return describe("navigate", function() {
        return it("should replace last history entry when replace option is true", function() {
          Backbone.history = new Backbone.History;
          Backbone.history.stop();
          Backbone.history.start();
          Backbone.history.navigate('one');
          Backbone.history.navigate('two');
          Backbone.history.navigate('three', {
            replace: true
          });
          return window.location.hash.should.equal("#three");
        });
      });
    });
    return describe("Quiz", function() {
      return describe("navigate", function() {
        return it("should use the correct template and the provided model", function() {
          var quiz;
          quiz = new Quiz({
            exercises: this.exercises,
            choices: this.choices
          });
          Backbone.history.stop();
          Backbone.history.start();
          quiz.navigate('exercises/101', {
            trigger: true
          });
          return window.location.hash.should.equal("#exercises/101");
        });
      });
    });
  });

}).call(this);
