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

  # def upload
    # uploaded_io = params[:person][:picture]
    # File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      # file.write(uploaded_io.read)
    # end
  # end

  def import_xml
    f =  File.open("./Mindmailer.xml")
    xmlcourses = Nokogiri::XML(f)

    xmlcourses.xpath('//course').each do |xmlcourse|
    # xmlcoursename = @xmlcourse["name"]
    # xmlcoursedescription = @xmlcourse["description"]

      importcourse = Course.new(
      :topic => xmlcourse['name'],
      :description => xmlcourse['description']
      )

      xmlcourse.xpath("lesson").each do |xmllesson|
        importtopic = Topic.new(
        :name => xmllesson["name"],
        :description => xmllesson["description"],
        :course_id => importcourse.id
        )
        xmllesson.xpath("question").each do |xmlquestion|
          importquestion = Question.new(
          :questiontype => xmlquestion["type"],
          :name => xmlquestion["name"],
          :body => xmlquestion["body"],
          :noticewrong => xmlquestion["notice_on_wrong"],
          :noticeright => xmlquestion["notice_on_correct"],
          :notice => xmlquestion["notice"],
          :topic_id => importtopic.id
          )
          # xmllesson.elements.each("XPath") do |node| ??
          xmllesson.xpath("question").each do |xmlanswer|
            importanswer = Answer.new(
            :notice => xmlanswer["notice"],
            :body => xmlanswer["body"],
            :correct => xmlanswer["correct"],
            :pattern => xmlquestion["pattern"],
            :question_id => importquestion.id
            )

          end
        end
      end
    end
    f.close

  end
end
