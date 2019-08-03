Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :donations, only: [] do
    collection do
      get :graph, defaults: { format: :json }
    end
  end

  resources :users, only: :show
  resource :home, only: :show
  root 'home#show'
end
