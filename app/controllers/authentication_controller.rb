class AuthenticationController < ApplicationController
  def login
    if current_user != nil
      redirect_to courses_path
    end
  end

  def signin
    username = params[:user][:username]
    password = params[:user][:password]

    user = User.authenticate_by_username(username, password)

    if user
      session[:user_id] = user.id
      flash[:notice] = 'Sie haben sich erfolgreich eingeloggt. Willkommen ...'
      redirect_to courses_path
    else
      flash.now[:error] = 'Login Fehlgeschlagen. Bitte Benutzername und Passwort pruefen'
      render :action => "login"
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "Sie haben sich erfolgreich ausgeloggt ..."
    redirect_to login_path
  end
end
