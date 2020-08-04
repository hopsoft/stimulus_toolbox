# frozen_string_literal: true

# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  namespace :admin do
    resources :projects
    resources :full_text_searches
    root to: "projects#index"
  end

  resources :projects, only: [:index, :show, :new, :create]
  get "projects/page/:page/(query/:query)", to: "projects#index", as: :paginated_projects
  get "projects/page/:page/query", to: redirect("/projects/page/1")

  get "home/index"
  root "home#index"
end
