require 'green_light'

module Enlightenment
  class Rules < GreenLight::Rules
    include Validations::ValidatesAssociated
    include Validations::ValidatesCallback
    include Validations::ValidatesUniqueness

    class << self
      def generate(models)
        data = {}

        models.each do |model|
          key   = model.to_s.underscore.downcase
          rules = {}

          model.constantize._validators.each do |field, validators|
            rules[field] = parse_each_validation(model, field, validators)
          end

          data[key] = { :rules => rules }
        end

        { :resources => data }.to_json
      end

      private

        # TODO: be sure to APPEND ajax versions, so they run last
        def parse_each_validation(model, field, validators)
          data, params = {}, {}
          params[:model], params[:field] = model, field

          validators.each do |validator|
            params[:val_obj] = validator
            method = validator.class.name.split('::').last.underscore

            if respond_to?(method)
              result = send(method, params)
              data.merge!(result) unless result.nil?
            else
              data.merge!(callback_validator(params))
            end
          end

          data
        end
    end
  end
end
