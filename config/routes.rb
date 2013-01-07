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
  resources :schools, only: [] do
    resources :articles, only: [:index], controller: 'school_articles'
  end
  resources :activities, only: [] do
    resources :articles, only: [:index], controller: 'activity_articles'
  end
  resources :writers, only: [] do
    resources :articles, only: [:index], controller: 'writer_articles'
  end
  resources :events, only: :index

  get 'team', controller: 'pages'
  get 'about_us', controller: 'pages'
  get 'contact_us', controller: 'pages'
  get 'contribute', controller: 'pages', action: 'contact_us'
  get 'terms', controller: 'pages'
  get 'instagram', controller: 'pages'

  root to: 'home_articles#index'
end
