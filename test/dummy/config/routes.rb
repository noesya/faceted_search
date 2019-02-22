Rails.application.routes.draw do
  resources :categories, :products, :kinds, :items
  root to: 'root#index'
end
