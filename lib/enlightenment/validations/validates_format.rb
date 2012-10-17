module Enlightenment
  module Validations
    module ValidatesFormat
      extend ActiveSupport::Concern

      module ClassMethods
        def format_validator(params = {})
          { :regex => params[:val_obj].options[:with].inspect }
        end
      end
    end
  end
end
