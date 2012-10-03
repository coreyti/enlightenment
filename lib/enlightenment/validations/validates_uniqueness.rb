module Enlightenment
  module Validations
    module ValidatesUniqueness
      extend ActiveSupport::Concern

      module ClassMethods
        def uniqueness_validator(params = {})
          callback_validator(params)
        end
      end
    end
  end
end
