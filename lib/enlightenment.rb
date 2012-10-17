require 'enlightenment/engine'
require 'i18n-js'

# TODO
#
# primary:
#
#   * [*] store validations for non-existent forms (they may show up)
#   * [*] handle dynamic field additions     -- may require patching jquery.validate (DID NOT)
#   * [*] define validation method for AssociatedValidator
#   * [*] add validation via AJAX callback
#   * [ ] add i18n messages                  -- may require patching jquery.validate
#   * [ ] add i18n messages WITH interpolation (functions)
#   * [ ] add support for "field error proc" -- may require patching jquery.validate
#   * [ ] remove simpleform/bootstrap specifics from validations.js (e.g., '.form-inputs')
#   * [ ] add sanitize config.  e.g., hide email "has already been taken" message.
#
# secondary:
#
#   * [ ] make js pseudo-agnostic (jQuery, Zepto or Ender)
#   * [ ] add gon-like "lifting"
#   * [ ] add asset and page caching, with exception hooks
#   * [ ] handle duplicate forms (e.g., registration at top AND bottom)
#   * [ ] add a config option to persist Validation records
#
# validators:
#
#   * [ ] ActiveModel::Validations::AcceptanceValidator
#   * [ ] ActiveModel::Validations::ConfirmationValidator
#   * [ ] ActiveModel::Validations::ExclusionValidator
#   * [ ] ActiveModel::Validations::FormatValidator         --> green_light
#   * [ ] ActiveModel::Validations::InclusionValidator
#   * [ ] ActiveModel::Validations::LengthValidator         --> green_light
#   * [ ] ActiveModel::Validations::NumericalityValidator   --> green_light
#   * [ ] ActiveModel::Validations::PresenceValidator       --> green_light
#   * [ ] ActiveModel::Validations::WithValidator
#   * [ ] ActiveModel::Validator
#   * [ ] ActiveRecord::Validations::AssociatedValidator
#   * [ ] ActiveRecord::Validations::UniquenessValidator    --> green_light via remote
#
module Enlightenment
  autoload :Rules,                  'enlightenment/rules'

  module Validations
    autoload :CallbackValidator,    'enlightenment/validations/callback_validator'
    autoload :CleanupValidator,     'enlightenment/validations/cleanup_validator'
    autoload :ValidatesAssociated,  'enlightenment/validations/validates_associated'
    autoload :ValidatesFormat,      'enlightenment/validations/validates_format'
    autoload :ValidatesUniqueness,  'enlightenment/validations/validates_uniqueness'
  end

  mattr_accessor :pages_layout
  @@pages_layout = 'application'

  mattr_accessor :validate_models
  @@validate_models = {}

  mattr_accessor :validate_config
  @@validate_config = {}

  mattr_accessor :message_sanitizer
  @@message_sanitizer = nil

  def self.setup
    yield self
  end
end
