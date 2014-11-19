Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resource :session
    resources :users
  end
end
