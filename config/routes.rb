Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'drugs#index'
  resources :drugs, only: [:index, :create], defaults: { format: :json } do 
    get :dosage, on: :collection
    get :full_list, on: :collection
    post :take_a_pill, on: :member
  end
end
