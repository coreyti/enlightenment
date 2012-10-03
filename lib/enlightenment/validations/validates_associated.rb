module Enlightenment
  module Validations
    module ValidatesAssociated
      extend ActiveSupport::Concern

      module ClassMethods
        def associated_validator(params = {})
          field = params[:field].to_s.singularize
          { :associated => field.to_sym }
        end
      end
    end
  end
end
