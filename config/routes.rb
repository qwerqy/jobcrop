Rails.application.routes.draw do


  get 'live_chat/index'
  get 'bookings/create'
  get 'home' => 'home#index'
  get '/side' => 'home#side'
  root 'landing#index'

  resources :search, controller: 'search', only: [:create]
  get '/search' => 'search#create', as: 'search'
  post '/search/filter' => 'search#filter', as: 'search_filter'

  resources :passwords, controller: "passwords", only: [:create, :new]
  resource :session, controller: "sessions", only: [:create]
  resources :users, controller: "users", only: [:update, :create, :show, :new] do
      resources :educations
      resources :experiences
      resources :skills
      resources :languages
      resources :projects
      resources :jobhunter, controller: "jobhunters", only: [:index, :new, :create, :update, :edit]
    get "/about_me" => 'users#about_me'
    get "/edit_name" => 'users#edit_name'
    get "/edit_about_me" => 'users#edit_about_me'
    get "/edit_email" => 'users#edit_email'
    get "/edit_phone" => 'users#edit_phone'
    get "/edit_birthday" => 'users#edit_birthday'
    get "/edit_location" => 'users#edit_location'
    patch "/add_skill" => 'users#add_skill'
    delete "/remove_skill/:id" => 'users#remove_skill', as: 'remove_skill'

    resource :password,
      controller: "passwords",
      only: [:create, :edit, :update]

    resources :employer, controller: "employers", only: [:edit, :update, :create]
  end

  resources :conversation, controller: "conversations", only: [:index, :show]
  resources :personal_messages, only: [:new, :create]

  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"

  # For employer
  get "/employer/dasboard" => "employers#dashboard", as: "employer_dashboard"
  # get "/employer/analysis" => "analysis#index", as: "employer_analysis"
  get "/employer/jobs" => 'jobs#index', as: 'jobs_index'
  get "/employer/company/:id/timeline_page" => "employer_timelines#index", as: "timeline_page"
  get "/employer/company/:id/review_page" => "employers#review_page", as: "review_page"
  resources :employer, controller: 'employers', only: [:index, :new] do
    resource :review, controller: 'reviews', only: [:create, :new, :destroy]
  end
  resources :company, controller: 'companies', only: [:index, :new, :create, :show] do
    resource :follow, controller: "follows", only: [:create, :destroy]
    get '/about' => 'companies#about', as: 'about'
    get '/reviews' => 'companies#reviews', as: 'reviews'
    resources :jobs, controller: "jobs", only: [:show, :new, :create, :edit] do
      resources :booking, controller: 'bookings', only: [:new, :create, :show]
    end
  end
  resources :booking, controller: 'bookings', only: [:index]

  delete "/employer_jobs/:id" => "employer_jobs#delete", as: "delete_employer_job"
  delete "/employer_timelines/:id" => "employer_timelines#delete", as: "delete_employer_timeline"


  post '/user-pre-employer' => 'users#create_pre_employer', as: 'create_pre_employer'
  resources :employer_timelines, controller: "employer_timelines"







  get "/employer/review_analysis" => "analysis#review_analysis", as: "employer_review_analysis"
  get "/employer/job_analysis" => "analysis#job_analysis", as: "employer_job_analysis"
  get "/employer/applicant_analysis" => "analysis#applicant_analysis", as: "employer_applicant_analysis"
  get "/employer/follower_analysis" => "analysis#follower_analysis", as: "employer_follower_analysis"
end
