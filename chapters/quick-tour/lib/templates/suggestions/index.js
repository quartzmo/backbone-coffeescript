(function() {
  this.ecoTemplates || (this.ecoTemplates = {});
  this.ecoTemplates["suggestions/index"] = function(__obj) {
    if (!__obj) __obj = {};
    var __out = [], __capture = function(callback) {
      var out = __out, result;
      __out = [];
      callback.call(this);
      result = __out.join('');
      __out = out;
      return __safe(result);
    }, __sanitize = function(value) {
      if (value && value.ecoSafe) {
        return value;
      } else if (typeof value !== 'undefined' && value != null) {
        return __escape(value);
      } else {
        return '';
      }
    }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
    __safe = __obj.safe = function(value) {
      if (value && value.ecoSafe) {
        return value;
      } else {
        if (!(typeof value !== 'undefined' && value != null)) value = '';
        var result = new String(value);
        result.ecoSafe = true;
        return result;
      }
    };
    if (!__escape) {
      __escape = __obj.escape = function(value) {
        return ('' + value)
          .replace(/&/g, '&amp;')
          .replace(/</g, '&lt;')
          .replace(/>/g, '&gt;')
          .replace(/"/g, '&quot;');
      };
    }
    (function() {
      (function() {
      
        __out.push('<ol>\n  ');
      
        __out.push(__sanitize(this.collection.each(function(item) {
          __out.push('\n    <li>\n      <a href="#/show/');
          __out.push(__sanitize(item.id));
          __out.push('">\n        ');
          __out.push(__sanitize(item.get('subject')));
          return __out.push('\n      </a>\n    </li>\n  ');
        })));
      
        __out.push('\n</ol>\n<a href="#/new" class="btn btn-primary">\n  New Suggestion\n</a>');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  };
}).call(this);
