module Enlightenment
  class ValidationsController < Enlightenment::ApplicationController
    respond_to :json

    def create
      validation = Validation.new(params)

      if validation.pass?
        pass
      else
        fail(validation)
      end
    end

    private

      def pass(body = {})
        render(:json => body, :status => 201)
      end

      def fail(body = {})
        render(:json => body, :status => 403)
      end
  end
end
