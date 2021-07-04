Rails.application.routes.draw do
  
  root 'homes#index'
  
  # デバイス関連
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  # リスト関連
  resources :list, only: %i(new create index edit update destroy) do
    resources :card, only: %i(new create show edit update destroy)
  end

  patch 'list/:id/sort', to: 'list#sort'
end
