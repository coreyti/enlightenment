module Enlightenment
  class ApplicationController < ::ApplicationController
    def show(options = {})
      render(path, options)
    end

    private

      def path
        @_path ||= "#{controller_name}/#{params[:name].to_s.downcase}"
      end
  end
end
