Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'drugs#index'
  resources :drugs, only: [:index, :create, :destroy], defaults: { format: :json } do 
    get :dosage, on: :collection
    get :full_list, on: :collection
    post :take_a_pill, on: :member
  end
  resources :pharmacies, only: :index do
    # get :index2, on: :collection
  end
end
