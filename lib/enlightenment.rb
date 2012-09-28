require 'enlightenment/engine'

# TODO
#
# secondary:
#
#   * [ ] store validations for non-existent forms (they may show up)
#   * [ ] handle dynamic field additions     -- may require patching jquery.validate
#   * [ ] define validation method for AssociatedValidator
#   * [ ] add validation via AJAX callback
#   * [ ] add i18n messages                  -- may require patching jquery.validate
#   * [ ] add support for "field error proc" -- may require patching jquery.validate
#   * [ ] remove simpleform/bootstrap specifics from validations.js (e.g., '.form-inputs')
#
# secondary:
#
#   * [ ] make js pseudo-agnostic (jQuery, Zepto or Ender)
#   * [ ] add gon-like "lifting"
#   * [ ] add asset and page caching, with exception hooks
#   * [ ] handle duplicate forms (e.g., registration at top AND bottom)
#
module Enlightenment
  autoload :Rules, 'enlightenment/rules'

  mattr_accessor :validate_models
  @@validate_models = {}

  def self.setup
    yield self
  end
end
