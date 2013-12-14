class ImportsController < ApplicationController
  before_action :set_import, only: [:show, :edit, :update, :destroy, :import_file]
  def import_file(import)
    # import = import_id #Import.find(import_id)
    xmlcourses = Nokogiri::XML(File.read(import.xmlfile.path))
    parse_file(xmlcourses)
    # redirect_to courses_path
  end

  def parse_file(doc)
    doc.xpath('//course').each do |xmlcourse|

      importcourse = Course.create(
      :topic => xmlcourse['name'],
      :description => xmlcourse['description']
      )

      xmlcourse.xpath("lesson").each do |xmllesson|
        importtopic = Topic.create(
        :name => strip(xmllesson['name']),
        :description => strip(xmllesson['description']),
        :course_id => importcourse.id
        )
        xmllesson.xpath("question").each do |xmlquestion|
          importquestion = Question.create(
          :questiontype => strip(xmlquestion['type']),
          :name => strip(xmlquestion['name']),
          :body => strip(xmlquestion['body']),
          :noticewrong => strip(xmlquestion['notice_on_wrong']),
          :noticeright => strip(xmlquestion['notice_on_correct']),
          :notice => strip(xmlquestion['notice']),
          :topic_id => importtopic.id

          )
          if importquestion.questiontype == 'OpenQuestion'
            importanswer = Answer.create(
            :pattern => strip(xmlquestion['pattern']),
            :question_id => importquestion.id
          )
          else
            xmlquestion.xpath("answer").each do |xmlanswer|
              importanswer = Answer.create(
              :notice => strip(xmlanswer['notice']),
              :body => strip(xmlanswer['body']),
              :correct => strip(xmlanswer['correct']),
              :question_id => importquestion.id
              )
            end
          end
        end
      end
    end
  # f.close

  end
  
  def strip(htmlText)
    htmlText = htmlText.gsub(/<br \/>/, '\n')
    htmlText = htmlText.gsub(/<pre>\s*<br\s*\/>\s*<\/pre>/, "")
    htmlText = htmlText.gsub(/<pre>/, "<code>")
    htmlText = htmlText.gsub(/<\/pre>/, "</code>")
    return htmlText
  end
  

  # GET /imports
  # GET /imports.json
  def index
    @imports = Import.all
  end

  # GET /imports/1
  # GET /imports/1.json
  def show
  end

  # GET /imports/new
  def new
    @import = Import.new
  end

  # GET /imports/1/edit
  def edit
  end

  # POST /imports
  # POST /imports.json
  def create
    @import = Import.new(import_params)

    respond_to do |format|
      if @import.save
        format.html { redirect_to courses_path, notice: 'Datei erfolgreich importiert.' }
        format.json { render action: 'show', status: :created, location: @import }
      else
        format.html { render action: 'new' }
        format.json { render json: @import.errors, status: :unprocessable_entity }
      end
    end
    import_file(@import)
  end

  # PATCH/PUT /imports/1
  # PATCH/PUT /imports/1.json
  def update
    respond_to do |format|
      if @import.update(import_params)
        format.html { redirect_to @import, notice: 'Datei erfolgreich importiert.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @import.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /imports/1
  # DELETE /imports/1.json
  def destroy
    @import.destroy
    respond_to do |format|
      format.html { redirect_to imports_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_import
    @import = Import.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def import_params
    params.require(:import).permit(:useless, :xmlfile)
  end
end
