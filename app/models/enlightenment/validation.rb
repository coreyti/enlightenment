module Enlightenment
  class Validation
    attr_reader :model, :field, :attributes

    def initialize(params = {})
      @model = params[:model].constantize
      @field = params[:field].to_sym
      @attributes = params[model.table_name.singularize.to_sym]
    end

    def as_json(options = {})
      {
        :message  => (@messages || []).to_sentence,
        :complete => @complete.map { |k,v| [k, [v].flatten.uniq] }
      }
    end

    def pass?
      instance = model.new(attributes, :without_protection => true)
      instance.valid?
      @complete = instance.errors
      @messages = @complete.messages[field]

      @messages.blank?
    end
  end
end
