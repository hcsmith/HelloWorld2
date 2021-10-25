Rails.application.routes.draw do

  root to: "logs#index"

  get '/logs/display', to: 'logs#display', as: 'display' 

  get '/logs/detail' , to: 'logs#detail',  as: 'detail'

end
