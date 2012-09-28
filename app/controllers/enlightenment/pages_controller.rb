module Enlightenment
  class PagesController < Enlightenment::ApplicationController
    respond_to :html

    def show
      super
    end

    private

      # handle deprecation warning.
      def path
        super.sub(/\.html$/, '')
      end
  end
end
