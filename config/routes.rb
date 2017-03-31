Rails.application.routes.draw do
  root to: redirect('/accounts')

  put '/accounts/batch', to: 'accounts#batch_update'
  post '/accounts/batch', to: 'accounts#batch_create'
  get '/accounts/batch/new', to: 'accounts#batch_new'
  get '/accounts/batch/edit', to: 'accounts#batch_edit'

  put '/transactions/batch', to: 'transactions#batch_update'
  post '/transactions/batch', to: 'transactions#batch_create'
  get '/transactions/batch/new', to: 'transactions#batch_new'
  get '/transactions/batch/edit', to: 'transactions#batch_edit'

  put '/assets/batch', to: 'assets#batch_update'
  post '/assets/batch', to: 'assets#batch_create'
  get '/assets/batch/new', to: 'assets#batch_new'
  get '/assets/batch/edit', to: 'assets#batch_edit'

  resources :accounts
  resources :transactions
  resources :assets

  namespace :reports do
    get :allocation, to: 'allocation#show'
    get :price, to: 'price#show'
    get :value, to: 'value#show'
    get :performance, to: 'performance#show'
    get :returns, to: 'returns#show'
  end
end
