Rails.application.routes.draw do
  # Définir les routes pour l'application
  get "home/index"

  # Définir la page d'accueil
  root 'home#index'

  # Route pour vérifier l'état de santé de l'application
  get "up" => "rails/health#show", as: :rails_health_check

  # Routes pour l'authentification GitHub
  get '/auth/github', to: redirect('/auth/github/callback')
  get '/auth/github/callback', to: 'sessions#create'
  get '/auth/failure', to: redirect('/')
  get '/signout', to: 'sessions#destroy', as: 'signout'
end
