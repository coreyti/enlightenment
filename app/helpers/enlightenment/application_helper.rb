module Enlightenment
  module ApplicationHelper
    def method_missing(method, *args, &block)
      enlightenment.send(method, *args, &block)
    rescue NoMethodError
      main_app.send(method, *args, &block)
    rescue NoMethodError
      super
    end
  end
end
