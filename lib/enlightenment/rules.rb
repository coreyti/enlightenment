require 'green_light'

module Enlightenment
  class Rules < GreenLight::Rules
    include Validations::CallbackValidator
    include Validations::CleanupValidator
    include Validations::ValidatesAssociated
    include Validations::ValidatesUniqueness

    class << self
      def generate(models)
        data = {}

        models.each do |input|
          model, config = prepare(input)
          key        = model.underscore.downcase
          rules      = {}

          model.constantize._validators.each do |field, validators|
            options = {
              :whitelisted => (config.has_key?(:include)),
              :include     => (config[:include] || {})[field],
              :exclude     => (config[:exclude] || {})[field]
            }

            if (parsed = parse_validators(model, field, validators, options)) && parsed.present?
              rules[field] = parsed
            end
          end

          # (config[:cleanup] || []).each do |field|
          #   rules[field] = (rules[field] || {}).merge!(cleanup_validator)
          # end

          data[key] = { :rules => rules }
        end

        { :resources => data }.to_json
      end

      private

        def add(data, method, params)
          if respond_to?(method)
            result = send(method, params)
            data.merge!(result) unless result.nil?
          else
            data.merge!(callback_validator(params))
          end
        end

        def parse_validators(model, field, validators, options = {})
          data, params = {}, {}
          params[:model], params[:field] = model, field
          whitelisted = options[:whitelisted]
          includes    = options[:include] || []
          excludes    = options[:exclude] || []

          validators.each do |validator|
            params[:val_obj] = validator
            method  = validator.class.name.split('::').last.underscore

            # whitelisting wins... no excludes allowed if found
            if whitelisted
              if includes.include?(method.sub(/_validator$/, '').to_sym)
                add(data, method, params)
              end
            else
              unless excludes.include?(method.sub(/_validator$/, '').to_sym)
                add(data, method, params)
              end
            end
          end

          data
        end

        def prepare(input)
          if input.is_a?(String)
            [input, {}]
          else
            input
          end.flatten
        end
    end
  end
end
