Rails.application.routes.draw do
  scope '/api' do
    resource :user, only: [:show]
    post '/login', to: 'sessions#create'

    resources :tier_lists, only: [:index, :show, :create, :update, :destroy] do
      resources :comments, only: [:index]
    end
  end
end
