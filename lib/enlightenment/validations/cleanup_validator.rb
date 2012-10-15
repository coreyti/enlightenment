module Enlightenment
  module Validations
    module CleanupValidator
      extend ActiveSupport::Concern

      module ClassMethods
        def cleanup_validator(params = {})
          { :cleanup => true }
        end
      end
    end
  end
end
