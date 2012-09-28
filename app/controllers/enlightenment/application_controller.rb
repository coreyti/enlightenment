module Enlightenment
  class ApplicationController < ActionController::Base
    def show(options = {})
      render(path, options)
    end

    private

      def path
        @_path ||= "#{controller_name}/#{params[:name].to_s.downcase}"
      end
  end
end
