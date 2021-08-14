Rails.application.routes.draw do
  namespace 'api' do
    resources :tasks, only: [:index]
    resources :goals, only: %i[index create]
  end
end