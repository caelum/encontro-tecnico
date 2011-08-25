TTS::Application.routes.draw do
  devise_for :users
  root to: "scheduler#index"

  match '/mine' => "presentations#mine", :as => "mine"

  match '/calendario' => "calendar#index", :as => "calendar"

  resources :presentations do
    match '/accept' => "presentations#accept", :as => "accept_suggestion"
    match '/reject' => "presentations#reject", :as => "reject_suggestion"
    match '/suggest' => "presentations#suggest", :as => "suggest"
  end

end
