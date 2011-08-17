TTS::Application.routes.draw do
  root to: "scheduler#index"

  devise_for :users

  resources :presentations do
    match '/accept' => "presentations#accept", :as => "accept_suggestion"
  end

end
