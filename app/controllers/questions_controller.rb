class QuestionsController < ApplicationController
  before_filter :authenticate_user
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  def select
    @question = Question.find(params[:id])
    session[:question_id] = @question.id
    session[:questiontype] = @question.questiontype
    redirect_to answers_path
  end

  # GET /questions
  # GET /questions.json
  def index
    # @questions = Question.all
    @currenttopic = Topic.find_by_id(session[:topic_id])
    @questions = @currenttopic.questions

    respond_to do |format|
      format.html
      format.json { render json: @questions }
    end
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    if params[:t_id] != nil
      @topic = Topic.find(params[:t_id])
      @@t_id = @topic.id
    elsif
    @@t_id = nil
    end

    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    if @@t_id != nil
      @currenttopic = Topic.find_by_id(@@t_id)
      @@t_id = nil
    elsif
     @currenttopic = Topic.find_by_id(session[:topic_id])
    end
    @question.topic_id = @currenttopic.id

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render action: 'show', status: :created, location: @question }
      else
        format.html { render action: 'new' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    @question = Question.find(params[:id])
    @currenttopic = Topic.find_by_id(session[:topic_id])
    @question.topic_id = @currenttopic.id

    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_question
    @question = Question.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def question_params
    params.require(:question).permit(:questiontype, :name, :body, :noticewrong, :noticeright, :notice, :topic_id)
  end
end
