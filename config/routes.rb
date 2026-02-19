Rails.application.routes.draw do
  resources :authors
  resources :sections
  resources :articles, only: [:index, :show]
  resources :magazines

  namespace :front do
    resources :magazines, only: :index
    resources :articles, only: :show
    resources :sections, only: :show
  end

  namespace :edit do
    resources :pages, only: :index
    resources :articles
    resources :sections do
      resources :articles, only: :index
    end
    resources :features
    resources :magazines
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
