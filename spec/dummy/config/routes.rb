Rails.application.routes.draw do
  mount Enlightenment::Engine => "/enlightenment"
  mount Jasminerice::Engine   => "/jasmine"

  get 'jasmine/:suite' => 'jasminerice/spec#index'
end
