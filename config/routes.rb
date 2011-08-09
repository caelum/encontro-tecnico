TTS::Application.routes.draw do
  root to: "scheduler#index"

  devise_for :users


end
