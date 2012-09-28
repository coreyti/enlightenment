require 'green_light'

module Enlightenment
  class Rules < GreenLight::Rules
    include Validations::ValidatesAssociated

    class << self
      def generate(models)
        data = {}

        models.each do |model|
          key   = model.to_s.underscore.downcase
          rules = {}

          model.constantize._validators.each do |field_name, validations|
            rules[field_name] = parse_each_validation(model, field_name, validations)
          end

          data[key] = { :rules => rules }
        end

        { :resources => data }.to_json
      end
    end
  end
end
