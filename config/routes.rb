Rails.application.routes.draw do

  devise_for :users
  root to: "homes#top"

  #検索機能
  get 'search', to: "topics#search",as: 'search'

  resources :users,only:[:show,:edit,:update] do
     get 'liked_comments', to: 'topic_comments#liked_comments'
   end

  # ゲストユーザーログイン
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  resources :topics,only:[:new,:create,:index,:show,:edit,:update,:destroy] do
    resources :topic_comments,only:[:create,:destroy] do
      resources :likes,only:[:create,:destroy]
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
