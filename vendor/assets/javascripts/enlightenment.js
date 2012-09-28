//= require jquery.validate

(function($) {
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
        // from : user_friends_attributes[0]name
        //   to : user_friends_attributes[1234567890]name
        clone.find('[name]').each(function() {
          var elem = $(this);
          elem.attr('name', elem.attr('name').replace(/\[[0-9]+\]/g, '[' + indicator + ']'));
        });

        source[placement](clone);
        result.push(clone[0]);

        $(document).trigger('foo', clone.closest('form'));
      });

      return $(result);
    }
  });
})(jQuery);
