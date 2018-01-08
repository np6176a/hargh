Rails.application.routes.draw do
  resources :hars, only: %i(create show update destroy) do
    resources :entries, only: %i(index) do
      get "aggregations", to: "entries#aggregations", on: :collection
    end
  end
end
