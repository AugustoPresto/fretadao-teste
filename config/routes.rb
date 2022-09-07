Rails.application.routes.draw do
  root 'users#index'

  resources :users
  get "users/:id/edit/update_gh_info", to: "users#update_gh_info", as: "update_gh_info"
end
