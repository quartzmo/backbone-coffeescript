(function() {

  describe('Models and Domain Logic', function() {
    describe("Backbone.Model", function() {
      before(function() {
        return this.score = new Backbone.Model({
          points: 0
        });
      });
      describe("get", function() {
        return it("should have initial value for attribute 'points'", function() {
          return this.score.get('points').should.equal(0);
        });
      });
      return describe("set", function() {
        return it("should return set value for attribute 'points'", function() {
          this.score.set('points', 1);
          return this.score.get('points').should.equal(1);
        });
      });
    });
    describe("Score", function() {
      before(function() {
        return this.score = new Score;
      });
      describe("increment", function() {
        return it("should increment 'points' by 1 for each call to increment", function() {
          this.score.get('points').should.equal(0);
          this.score.increment().increment();
          return this.score.get('points').should.equal(2);
        });
      });
      return describe("validate", function() {
        return it("should return false for isValid when 'points' is less than 0", function() {
          this.score.set('points', -1);
          return this.score.isValid().should.be["false"];
        });
      });
    });
    describe("Backbone.Model", function() {
      before(function() {
        this.model1 = new Backbone.Model;
        this.model2 = new Backbone.Model;
        return this.model2.cid = this.model1.cid;
      });
      describe("equals", function() {
        return it("should not determine Model identity", function() {
          return this.model1.cid.should.equal(this.model2.cid);
        });
      });
      return describe("cid", function() {
        return it("should determine Model identity", function() {
          return this.model1.cid.should.equal(this.model2.cid);
        });
      });
    });
    describe("Score", function() {
      describe("url", function() {
        return it("should include Model id in path", function() {
          var score;
          score = new Score({
            id: '5'
          });
          return score.url().should.equal('/api/practice/scores/5');
        });
      });
      describe("toJSON", function() {
        return it("should serialize with a root 'score' property", function() {
          var json, score;
          score = new Score({
            id: "987654321",
            points: 25
          });
          json = score.toJSON();
          json.should.have.property("score");
          json.score.should.have.property("id", "987654321");
          return json.score.should.have.property("points", 25);
        });
      });
      return describe("parse", function() {
        return it("should parse from JSON with a root 'score' property", function() {
          var json, options, score;
          json = {
            "score": {
              "id": "987654321",
              "points": 25
            }
          };
          options = {
            parse: true
          };
          score = new Score(json, options);
          score.get('id').should.equal("987654321");
          return score.get('points').should.equal(25);
        });
      });
    });
    return describe("Backbone.Model", function() {
      return describe("freestyle", function() {
        return it("should support isNew, urlRoot, id, unset, has, escape, clear, attributes", function() {
          var message;
          message = new Backbone.Model({
            subject: "I <3 Backbone.js",
            body: "All the way!"
          });
          message.isNew().should.be["true"];
          message.urlRoot = "/phony";
          message.id = "a1";
          message.isNew().should.be["false"];
          message.url().should.equal("/phony/a1");
          message.unset('body');
          message.has('body').should.be["false"];
          message.escape('subject').should.equal("I &lt;3 Backbone.js");
          message.clear();
          return message.attributes.should.be.empty;
        });
      });
    });
  });

}).call(this);
