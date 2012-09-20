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

  resources :articles, only: [:index, :show]

  get 'team', controller: 'pages'
  get 'about_us', controller: 'pages'
  get 'our_story', controller: 'pages'
  get 'contact_us', controller: 'pages'
  get 'contribute', controller: 'pages', action: 'contact_us'
  get 'jobs', controller: 'pages'
  get 'media', controller: 'pages'
  get 'terms', controller: 'pages'

  root to: 'home_articles#index'
end
