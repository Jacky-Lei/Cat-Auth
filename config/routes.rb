NinetyNineCatsDay1::Application.routes.draw do
  resources :cats, except: :destroy
  resources :cat_rental_requests, only: [:create, :new] do
    post "approve", on: :member
    post "deny", on: :member
  end

  # session is the cookie of the browser
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]

  root to: redirect("/cats")
end
