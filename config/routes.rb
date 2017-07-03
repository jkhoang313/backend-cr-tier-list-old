Rails.application.routes.draw do
  scope '/api' do
    resources :tier_lists, only: [:index, :show, :create, :update, :delete]
    resources :users
  end
end
