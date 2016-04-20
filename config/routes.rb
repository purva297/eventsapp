Rails.application.routes.draw do
  resources :appointments
  post '/rsvp', to: 'appointments#rsvp'

  
  # You can have the root of your site routed with "root"
  root 'appointments#index'
end
