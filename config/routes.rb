# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  namespace :admin do
    resources :projects
    resources :full_text_searches
    root to: "projects#index"
  end

  resources :projects

  get "home/index"
  root "home#index"
end
