Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


# add transaction
  post 'user/transactions/new', to: 'transaction#create'

# spend points according to ruesl
  get 'user/transactions/spend', to: 'transaction#spend'

# list all payers
  get '/user/payers', to: 'user#payers'



end
