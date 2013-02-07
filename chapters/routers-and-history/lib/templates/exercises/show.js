(function() {
  this.ecoTemplates || (this.ecoTemplates = {});
  this.ecoTemplates["exercises/show"] = function(__obj) {
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
      
        __out.push('<label class="control-label">');
      
        __out.push(__sanitize(this.exercise.get('body')));
      
        __out.push('</label>\n<div class="form-actions">\n  <input type="submit" class="btn btn-primary" value="Submit">\n  ');
      
        if (this.next) {
          __out.push('\n    <a href="#exercises/');
          __out.push(__sanitize(this.next.id));
          __out.push('" class="btn">Next</a>\n  ');
        } else {
          __out.push('\n    <input type="button" class="btn" disabled="disabled" value="Next">\n  ');
        }
      
        __out.push('\n  <span class="notice"></span>\n</div>');
      
      }).call(this);
      
    }).call(__obj);
    __obj.safe = __objSafe, __obj.escape = __escape;
    return __out.join('');
  };
}).call(this);
