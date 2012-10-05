module Enlightenment
  class AssetsController < Enlightenment::ApplicationController
    respond_to :js

    def show
      super({
        :layout => false,
        :locals => {
          :config => validate_config,
          :models => validate_models
        }
      })
    end

    private

      # handle deprecation warning.
      def path
        super.sub(/\.js$/, '')
      end

      def validate_config
        config = Enlightenment.validate_config
        config.present? ? config.to_json : nil
      end

      def validate_models
        Enlightenment::Rules.generate(Enlightenment.validate_models)
      end
  end
end
