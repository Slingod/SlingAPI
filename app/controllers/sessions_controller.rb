class SessionsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create]
  
    def create
      auth = request.env['omniauth.auth']
      user = User.find_or_create_by(uid: auth['uid'], provider: auth['provider']) do |u|
        u.name = auth['info']['name']
        u.email = auth['info']['email']
      end
      session[:user_id] = user.id
      redirect_to root_path, notice: "Connexion réussie avec GitHub !"
    end
  
    def destroy
      session[:user_id] = nil
      redirect_to root_path, notice: "Déconnexion réussie !"
    end
  end
  