Rails.application.routes.draw do
  devise_for :users,
             path: '', path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'sign_up'
             }, controllers: {
               sessions: 'sessions',
               registrations: 'registrations',
               passwords: 'passwords'
             }

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :tasks, except: :new
    end
  end
end
