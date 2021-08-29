Rails.application.routes.draw do
  devise_for :users,
      controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
      }
  get '/member-data', to: 'members#show'
  namespace 'api' do
    resources :tasks, only: [:index]
    resources :goals
  end
end