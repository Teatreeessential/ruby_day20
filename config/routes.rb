Rails.application.routes.draw do
  resources :chat_rooms do
    member do
      post '/join' =>'chat_rooms#user_admit_room', as: 'join' ##해당 경로의 prefix지정 
      post '/chat' => 'chat_rooms#chat'
      delete '/exit' => 'chat_rooms#user_exit_room'
    end
  end
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'chat_rooms#index'
end
