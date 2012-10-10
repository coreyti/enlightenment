//= require i18n
//= require i18n/translations
//= require jquery.validate

(function($) {
  $.enlightenment = {};



  // extensions to jquery
  // --------------------------------------------------------------------------
  $.fn.extend({
    // like $.fn.clone, but with `id` and `name` corrections.
    duplicate : function duplicate(placement, withDataAndEvents, deepWithDataAndEvents) {
      var now    = (new Date()).getTime();
      var result = [];
      duplicate.counter = duplicate.counter || 0;

      this.each(function() {
        var indicator;
        var source = $(this);
        var clone  = source.clone(withDataAndEvents, deepWithDataAndEvents);

        duplicate.counter += 1;
        indicator = ["", now, duplicate.counter].join(''); // in case we're duplicating many

        // id...
        // from : user_friends_attributes_0_name
        //   to : user_friends_attributes_1234567890_name
        clone.find('[id]').each(function() {
          var elem = $(this);
          elem.attr('id', elem.attr('id').replace(/_[0-9]+_/g, '_' + indicator + '_'));
        });

        // name...
        // from : user_[friends_attributes][0][name]
        //   to : user_[friends_attributes][1234567890][name]
        clone.find('[name]').each(function() {
          var elem = $(this);
          elem.attr('name', elem.attr('name').replace(/\[[0-9]+\]/g, '[' + indicator + ']'));
        });

        source[placement](clone);
        result.push(clone[0]);

        clone.closest('form').trigger('revalidate');
      });

      return $(result);
    }
  });

  // extensions to jquery.validate
  // --------------------------------------------------------------------------
  $.validator.addMethod('regex', function(value, element, regexp) {
      var check = false;
      var re = new RegExp(regexp.replace('\\A', '^').replace('\\z', '$'));
      return this.optional(element) || re.test(value);
    },
    'You have entered an invalid value for this field'
  );

  $.validator.addMethod('remote', function(value, element, url) {
    if(this.optional(element)) {
      return "dependency-mismatch";
    }

    var validator = this;
    var form      = $(element).closest('form');
    var name      = element.name;
    var previous  = this.previousValue(element);

    if( ! this.settings.messages[element.name]) {
      this.settings.messages[element.name] = {};
    }

    previous.originalMessage = this.settings.messages[element.name].remote;
    this.settings.messages[element.name].remote = previous.message;

    if ( this.pending[element.name] ) {
      return "pending";
    }
    if ( previous.old === value ) {
      return previous.valid;
    }

    previous.old = value;
    this.startRequest(element);

    $.ajax({
      url      : url,
      type     : 'post',
      dataType : 'json',
      data     : form.serialize(),

      beforeSend : function beforeSend(xhr, settings) {
        if(pending[name]) {
          pending[name].abort();
        }

        pending[name] = xhr;
      },

      complete : function complete(xhr, status) {
        delete pending[name];
      },

      success : function success(response, status, xhr) {
        var submitted = validator.formSubmitted;

        validator.settings.messages[element.name].remote = previous.originalMessage;
        validator.prepareElement(element);
        validator.formSubmitted = submitted;
        validator.successList.push(element);

        delete validator.invalid[element.name];
        validator.showErrors();

        previous.valid = true;
        validator.stopRequest(element, true);
      },

      error : function error(xhr, status, error) {
        var text = xhr.responseText;
        validator.settings.messages[element.name].remote = previous.originalMessage;

        if(text) {
          var response = JSON.parse(text);
          var errors   = {};
          errors[element.name] = previous.message = response.message;

          validator.invalid[element.name] = true;
          validator.showErrors(errors);

          previous.valid = false;
          validator.stopRequest(element, false);
        }
      }
    });

    return "pending";
  });

  $.validator.prototype.addWrapper = function(target) {
    if(this.settings.wrapper) {
      target = target.add(target.closest(this.settings.wrapper));
    }

    return target;
  };

  // TODO: make non-specific to bootstrap & app-custom label
  $.validator.prototype.errorsFor = function(element) {
    return $(element).closest('div.controls').find('label.error');
  };

  $.validator.messages = {
    required    : message('invalid'),
    // remote      : message('invalid'),
    email       : message('invalid'),
    url         : message('invalid'),
    date        : message('invalid'),
    dateISO     : message('invalid'),
    number      : message('invalid'),
    digits      : message('invalid'),
    creditcard  : message('invalid'),
    equalTo     : message('invalid'),
    maxlength   : message('invalid'),
    minlength   : message('invalid'),
    rangelength : message('invalid'),
    range       : message('invalid'),
    max         : message('invalid'),
    min         : message('invalid')
  };

  var pending = {};

  function message(key) {
    return function message(parameters, field) {
      return I18n.t(key, { scope : 'activerecord.errors.messages' });
    }
  }
})(jQuery);
