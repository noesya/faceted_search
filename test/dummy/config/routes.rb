Rails.application.routes.draw do
  resources :styles
  resources :categories, :products, :kinds, :items
  root to: 'root#index'
end
