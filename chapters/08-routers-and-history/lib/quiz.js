// Generated by CoffeeScript 1.6.1
(function() {
  var ChoiceShowView, ChoicesIndexView, ExerciseShowView, Solutions, root;

  root = this;

  Solutions = Backbone.Collection.extend({
    url: '/api/practice/solutions'
  });

  ChoiceShowView = Backbone.View.extend({
    tagName: 'label',
    className: 'radio',
    template: JST['choices/show'],
    render: function() {
      this.$el.html("<input type=\"radio\" name=\"choices\" value=\"" + this.model.id + "\">");
      this.$el.append(this.model.escape('body'));
      return this;
    }
  });

  ChoicesIndexView = Backbone.View.extend({
    className: 'controls well',
    render: function() {
      var _this = this;
      _(this.collection.where({
        exercise_id: this.model.id
      })).forEach(function(choice) {
        return _this.$el.append(new ChoiceShowView({
          model: choice
        }).render().el);
      });
      return this;
    }
  });

  ExerciseShowView = Backbone.View.extend({
    className: 'control-group well quiz',
    template: JST['exercises/show'],
    attributes: {
      style: 'min-height: 320px;'
    },
    events: {
      "click input[type='submit']": 'submit'
    },
    initialize: function(options) {
      this.choices = options.choices;
      this.solutions = options.solutions;
      return this.next = options.next;
    },
    render: function() {
      this.$el.html(this.template({
        exercise: this.model,
        next: this.next
      }));
      this.$('.control-label').after(new ChoicesIndexView({
        model: this.model,
        collection: this.choices
      }).render().el);
      return this;
    },
    submit: function() {
      var choiceId, options;
      choiceId = this.$("input[name='choices']:checked").val();
      if (!choiceId) {
        return this.$('.notice').text("Please select an answer.");
      }
      this.$("input[type='submit']").attr('disabled', 'disabled');
      options = {
        success: function(solution) {
          return this.$('.notice').text((solution.get('correct') ? 'Correct' : 'Incorrect'));
        },
        error: function(solution, response) {
          return console.log("Server error: " + response.status + " " + response.statusText + " " + response.responseText);
        }
      };
      return this.solutions.create({
        exercise_id: this.model.id,
        choice_id: choiceId
      }, options);
    }
  });

  root.Quiz = Backbone.Router.extend({
    routes: {
      'exercises/:id': 'show'
    },
    initialize: function(options) {
      this.exercises = options.exercises;
      this.choices = options.choices;
      return this.solutions = new Solutions();
    },
    show: function(id) {
      var exercise, view;
      exercise = this.exercises.get(id);
      view = new ExerciseShowView({
        model: exercise,
        next: this.exercises.at(this.exercises.indexOf(exercise) + 1),
        choices: this.choices,
        solutions: this.solutions
      });
      return $('.modal-content').html(view.render().el);
    }
  });

}).call(this);
