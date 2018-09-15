Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'drugs#index'
  resources :drugs, only: [:index, :create, :update], defaults: { format: :json } do 
    get :by_name, on: :collection
  end
end
