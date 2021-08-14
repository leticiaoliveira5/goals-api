Rails.application.routes.draw do
  namespace 'api' do
    resources :tasks, only: [:index]
    resources :goals, only: %i[index create destroy update edit]
  end
end