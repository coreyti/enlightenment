module Enlightenment
  class AssetsController < Enlightenment::ApplicationController
    respond_to :js

    def show
      super({
        :layout => false,
        :locals => { :validations => Enlightenment::Rules.generate(Enlightenment.validate_models) }
      })
    end

    private

      # handle deprecation warning.
      def path
        super.sub(/\.js$/, '')
      end
  end
end
