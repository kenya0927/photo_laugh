Rails.application.routes.draw do

  devise_for :users
  root to: "homes#top"

  resources :users,only:[:show,:edit,:update] do
    # いいねした投稿を取得するため
    member do
      get :likes
    end
  end

  resources :topics,only:[:new,:create,:index,:show,:edit,:update,:destroy] do
    resources :topic_comments,only:[:create,:destroy] do
      resources :likes,only:[:create,:destroy]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
