//= require jquery.validate

(function($) {
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
    var validator = this;
    var form      = $(element).closest('form');
    var previous  = this.previousValue(element);

    $.ajax({
      url      : url,
      type     : 'post',
      dataType : 'json',
      data     : form.serialize(),

      success : function success(response, status, xhr) {
        var submitted = validator.formSubmitted;

        validator.prepareElement(element);
        validator.formSubmitted = submitted;
        validator.successList.push(element);

        delete validator.invalid[element.name];
        validator.showErrors();

        previous.valid = true;
        validator.stopRequest(element, true);
      },

      error : function error(xhr, status, error) {
        var response = JSON.parse(xhr.responseText);
        var errors   = {};
        errors[element.name] = response.message;

        validator.invalid[element.name] = true;
        validator.showErrors(errors);

        previous.valid = false;
        validator.stopRequest(element, false);
      }
    });

    return "pending"; // TODO: i18n
  });
})(jQuery);
