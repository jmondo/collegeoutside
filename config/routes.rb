Collegeoutside::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users

  match 'write' => 'write/articles#index'
  namespace :write do
    resources :articles
  end

  root to: 'pages#index'
end
