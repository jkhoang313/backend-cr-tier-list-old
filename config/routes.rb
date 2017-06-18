Rails.application.routes.draw do
  scope '/api' do
    resources :tiers
    resources :tier_lists
    resources :users
  end
end
