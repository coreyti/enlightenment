Enlightenment::Engine.routes.draw do
  { :assets => :asset, :pages => :page }.each do |controller, as|
    match "#{controller}/:name" => "#{controller}#show",
      :as   => as,
      :name => /[a-z].*/,
      :via  => :get
  end

  match "pages(/?)" => "pages#show",
    :name => 'index',
    :via  => :get
end
