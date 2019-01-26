Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get 'signup', to: 'users#new'
  resources :users, except: [:new]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :courses, only: [:show, :index]
  resources :users, only: [:show, :index]
  resources :usercourses
  get 'add_teachers', to: 'courses#add_teacher'
  get 'add_courses', to: 'users#add_course'
  get 'search_courses', to: 'users#search'
  delete 'removeTakeCourse', to: 'users#removetake'
  post 'add_takecourse', to: 'users#add_takecourse'
end
