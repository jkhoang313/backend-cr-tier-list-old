Rails.application.routes.draw do
  scope '/api' do
    resources :tier_lists, only: [:index, :show, :create, :update, :destroy]
    resource :user, only: [:show]

    post '/login', to: 'sessions#create'
  end
end
