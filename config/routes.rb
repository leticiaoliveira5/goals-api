Rails.application.routes.draw do
  devise_for :users,
      controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
      }
  get '/member-data', to: 'members#show'
  namespace 'api' do
    namespace 'v1' do
      resources :goals, only: %i[index show create destroy update edit]
      resources :milestones, only: %i[show create destroy update edit]
      resources :steps, only: %i[show create destroy update edit]
    end  
  end
end