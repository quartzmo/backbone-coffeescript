(function() {
  var root;

  root = this;

  root.Suggestions = Backbone.Collection.extend({
    url: '/api/feedback/suggestions'
  });

  root.ShowView = Backbone.View.extend({
    template: '<h3>\n  <%= @model.get(\'subject\') %>\n</h3>\n<p>\n  <%= @model.get(\'message\') %>\n</p>\n<a href="#" class="btn">\n  Back\n</a>',
    render: function() {
      this.$el.html(eco.render(this.template, {
        model: this.model
      }));
      return this;
    }
  });

  root.IndexView = Backbone.View.extend({
    template: JST['suggestions/index'],
    render: function() {
      this.$el.html(this.template(this));
      return this;
    }
  });

  root.NewView = Backbone.View.extend({
    events: {
      'click #new-submit': 'create'
    },
    template: JST['suggestions/new'],
    render: function() {
      this.$el.html(this.template);
      return this;
    },
    create: function(event) {
      var options, suggestion;
      event.preventDefault();
      suggestion = {
        subject: this.$('#subject').val(),
        message: this.$('#message').val()
      };
      options = {
        wait: true,
        error: function(model, response) {
          var json;
          json = jQuery.parseJSON(response.responseText);
          return this.$('.alert').show().html(json.errors.join('<br>'));
        }
      };
      return this.collection.create(suggestion, options);
    }
  });

  root.App = Backbone.Router.extend({
    routes: {
      '': 'index',
      'new': 'new',
      'show/:id': 'show'
    },
    initialize: function(collection) {
      var _this = this;
      this.collection = collection;
      this.collection.on('add', function(model) {
        return _this.navigate("show/" + model.id, {
          trigger: true
        });
      });
      return this.navigate('');
    },
    index: function() {
      return this.collection.fetch({
        success: function(collection) {
          return $('.modal-content').html(new IndexView({
            collection: collection
          }).render().el);
        },
        error: function(collection, response) {
          throw new Error(response.status + ' ' + response.responseText);
        }
      });
    },
    "new": function() {
      return $('.modal-content').html(new NewView({
        collection: this.collection
      }).render().el);
    },
    show: function(id) {
      var suggestion;
      suggestion = this.collection.get(id);
      return $('.modal-content').html(new ShowView({
        model: suggestion
      }).render().el);
    }
  });

}).call(this);
