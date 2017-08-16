Rails.application.routes.draw do

  get '/', to: 'todos#index'

  resources :todos
end
