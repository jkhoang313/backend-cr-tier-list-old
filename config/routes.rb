Rails.application.routes.draw do
  scope '/api' do
    resources :tier_lists, only: [:index, :show, :create, :update, :destroy]
    resources :users
  end
end
