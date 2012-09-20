Collegeoutside::Application.routes.draw do
  mount RedactorRails::Engine => '/redactor_rails'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users

  match 'write' => 'write/articles#index'
  namespace :write do
    resources :articles
  end

  namespace :pages do
    get 'articles'
    get 'school'
    get 'author'
    get 'article'
  end
  get 'team', controller: 'pages'

  root to: 'pages#index'
end
