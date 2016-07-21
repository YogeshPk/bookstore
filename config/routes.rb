Rails.application.routes.draw do
  resources :search_suggestions
  resources :ratings
  resources :coauthors
  resources :reviews
  root :to => redirect('/books')
  devise_for :users , :controllers => { registrations: 'registrations' }
  resources :books 

  resources :categories
  resources :ratings, only: :update
  get 'books/:id/review', to: 'reviews#review'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
