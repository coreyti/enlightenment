Rails.application.config.assets.paths << Enlightenment::Engine.root.join('spec/javascripts')
Rails.application.config.assets.paths << Enlightenment::Engine.root.join('spec/stylesheets')
ActionController::Base.prepend_view_path Enlightenment::Engine.root
