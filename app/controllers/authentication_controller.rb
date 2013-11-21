class AuthenticationController < ApplicationController
  def login
  end

  def signin
    username = params[:user][:username]
    password = params[:user][:password]

    user = User.authenticate_by_username(username, password)

    if user
      session[:user_id] = user.id
      flash[:notice] = 'Willkommen.'
      redirect_to courses_path
    else
      flash.now[:error] = 'Login Fehlgeschlagen. Bitte Benutzername und Passwort pruefen'
      render :action => "login"
    end
  end
end
