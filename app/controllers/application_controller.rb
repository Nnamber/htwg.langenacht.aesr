class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :initObjectsForQuickstartNavigation
  protect_from_forgery
  helper_method :current_user
  
  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  def authenticate_user
    if current_user.nil?
      flash[:error] = 'Sie muessen sich zuerst Anmelden.'
      redirect_to login_path
    end
  end
  
  #Objekte müssen auf jeder Seite verfügbar sein und müssen daher ALLE von vorn herein entsprechende gespeichert werden
  def initObjectsForQuickstartNavigation
    $courses = Course.all
    $topics = Topic.all
    $questions = Question.all
  end
end
