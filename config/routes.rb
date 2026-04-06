Rails.application.routes.draw do
  devise_for :users
  
  root "movies#index"
  post "/recommend", to: "movies#recommend", as: "recommend"
end