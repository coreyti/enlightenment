require 'green_light'

module Enlightenment
  class Rules < GreenLight::Rules
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

      private

        def parse_each_validation(model, field_name, validation_objs)
          data, params = {}, {}
          params[:model], params[:field_name] = model, field_name

          validation_objs.each do |val_obj|
            # TODO: define a validation method
            if val_obj.is_a?(ActiveRecord::Validations::AssociatedValidator)
              data.merge!({ :associated => :friend }) # TODO: fix hard-coded
            else
              params[:val_obj] = val_obj
              # Call each validation method
              validation_method = val_obj.class.name.split('::').last.underscore
              result = send(validation_method, params) if respond_to? validation_method
              data.merge!(result) unless result.nil?
            end
          end

          data
        end
    end
  end
end
