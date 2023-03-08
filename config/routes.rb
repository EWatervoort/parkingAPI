Rails.application.routes.draw do
  get '/spots', to: 'spots#index'
  get '/spots/remaining', to: 'spots#remaining'
  get '/spots/:car_type', to: 'spots#cars_per_type'
  get '/spots/id/:id', to: 'spots#show'
  patch '/spots/add/:car_type', to: 'spots#add_vehicle'
  patch '/spots/remove/:car_type', to: 'spots#remove_vehicle'

end
