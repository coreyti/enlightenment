module Enlightenment
  class PagesController < Enlightenment::ApplicationController
    respond_to :html
    layout     :pages_layout

    def show
      super
    end

    private

      def pages_layout
        Enlightenment.pages_layout
      end

      # handles deprecation warning.
      def path
        super.sub(/\.html$/, '')
      end
  end
end
