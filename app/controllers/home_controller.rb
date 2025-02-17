class HomeController < ApplicationController
  require 'net/http'
  require 'json'
  require 'rest-client'

  def index
    if session[:user_id]
      @user = User.find(session[:user_id])

      # Utiliser l'API GitHub pour récupérer les dépôts de l'utilisateur
      begin
        response = RestClient.get('https://api.github.com/user/repos', {Authorization: "token #{@user.oauth_token}"})
        @repos = JSON.parse(response.body)
      rescue RestClient::ExceptionWithResponse => e
        @error = "Erreur lors de l'appel à l'API GitHub: #{e.response}"
      end
    end
  end
end
