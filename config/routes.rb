Rails.application.routes.draw do
  root to: 'pages#main'

  namespace :api, defaults: { format: :json } do
    resource :session, only: [:create, :destroy]
    resources :users, only: [:create, :update]
    resources :projects, except: [:new, :edit]
    resources :project_shares, only: [:create, :destroy]
    resources :two_way_plots, except: [:new, :edit]
  end
end
