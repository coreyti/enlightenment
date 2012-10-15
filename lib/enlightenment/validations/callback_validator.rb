module Enlightenment
  module Validations
    module CallbackValidator
      extend ActiveSupport::Concern

      module ClassMethods
        def callback_validator(params = {})
          { :remote => "/validations?model=#{params[:model].to_s}&field=#{params[:field]}" }
        end
      end
    end
  end
end
