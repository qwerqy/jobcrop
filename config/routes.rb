Rails.application.routes.draw do
  get 'home' => 'home#index'
  get 'jobs' => 'jobs#index'
  root 'landing#index'

  resources :passwords, controller: "passwords", only: [:create, :new]
  resource :session, controller: "sessions", only: [:create]
  resources :users, controller: "users", only: [:update, :create, :show] do
      resources :educations
      resources :experiences
      resources :skills
      resources :projects
    get "/about_me" => 'users#about_me'
    get "/edit_name" => 'users#edit_name'
    get "/edit_detail" => 'users#edit_detail'
    get "/edit_email" => 'users#edit_email'
    get "/edit_phone" => 'users#edit_phone'
    patch "/add_skill" => 'users#add_skill'
    delete "/remove_skill/:id" => 'users#remove_skill', as: 'remove_skill'

    resource :password,
      controller: "passwords",
      only: [:create, :edit, :update]
  end
  #
  # # homepage
  # get "users/home"
  # root "users#home"
  #
  # # userprofile route
  # get "users/profile"

  resources :users, only: [:profile] do
  end

  get "users/home"
  # get "/sign_in" => "sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"
end
