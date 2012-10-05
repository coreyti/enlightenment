require 'green_light'

module Enlightenment
  class Rules < GreenLight::Rules
    include Validations::ValidatesAssociated
    include Validations::ValidatesCallback
    include Validations::ValidatesUniqueness

    class << self
      def generate(models)
        data = {}

        models.each do |input|
          model, config = prepare(input)
          key        = model.underscore.downcase
          rules      = {}
          exclusions = config[:exclude] || {}

          model.constantize._validators.each do |field, validators|
            exclude = exclusions[field] || []
            rules[field] = parse_validators(model, field, validators, exclude)
          end

          data[key] = { :rules => rules }
        end

        { :resources => data }.to_json
      end

      private

        def parse_validators(model, field, validators, exclude = [])
          data, params = {}, {}
          params[:model], params[:field] = model, field

          validators.each do |validator|
            params[:val_obj] = validator
            method  = validator.class.name.split('::').last.underscore

            unless exclude.include?(method.sub(/_validator$/, '').to_sym)
              if respond_to?(method)
                result = send(method, params)
                data.merge!(result) unless result.nil?
              else
                data.merge!(callback_validator(params))
              end
            end
          end

          data
        end

        def prepare(input)
          if input.is_a?(String)
            { input => {} }
          else
            input
          end.flatten
        end
    end
  end
end
