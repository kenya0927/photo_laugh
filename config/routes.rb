Rails.application.routes.draw do

  devise_for :users
  root to: "homes#top"

  resources :users,only:[:show,:edit,:update]

  resources :topics,only:[:new,:create,:index,:show,:edit,:update,:destroy] do
    resources :topic_comments,only:[:create,:destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
