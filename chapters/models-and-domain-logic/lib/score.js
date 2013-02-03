(function() {
  var root;

  root = this;

  root.Score = Backbone.Model.extend({
    urlRoot: '/api/practice/scores',
    defaults: {
      points: 0
    },
    increment: function() {
      this.set('points', this.get('points') + 1);
      return this;
    },
    validate: function(attrs, options) {
      if (attrs.points < 0) return "'points' cannot be less than 0.";
    },
    toJSON: function() {
      return {
        "score": _.clone(this.attributes)
      };
    },
    parse: function(response) {
      return response.score;
    }
  });

}).call(this);
