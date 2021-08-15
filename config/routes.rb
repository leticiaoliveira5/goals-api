Rails.application.routes.draw do
  namespace 'api' do
    resources :goals, only: %i[index show create destroy update edit]
    resources :milestones, only: %i[show create destroy update edit]
  end
end