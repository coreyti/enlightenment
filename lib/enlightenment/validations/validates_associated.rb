module Enlightenment
  module Validations
    module ValidatesAssociated
      extend ActiveSupport::Concern

      module ClassMethods
        def associated_validator(params = {})
          field_name = params[:field_name].to_s.singularize
          { :associated => field_name.to_sym }
        end
      end
    end
  end
end
