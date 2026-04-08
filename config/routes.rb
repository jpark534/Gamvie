Rails.application.routes.draw do
  root "movies#index"
  post "/recommend", to: "movies#recommend", as: "recommend"
  get "/recommend", to: "movies#index"
  get "/api/recommendations", to: "movies#api_recommendations"
end