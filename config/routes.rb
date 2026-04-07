Rails.application.routes.draw do
  root "movies#index"
  post "/recommend", to: "movies#recommend", as: "recommend"
end