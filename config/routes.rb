Rails.application.routes.draw do
  scope '/api' do
    resources :tier_lists
    resources :users
  end
end
