class ProblemsController < ApplicationController

  def new
    @problem = Problem.new
    @lists = List.all
  end

#Show report details and only show selected problem in gmap
  def show
    @problem = Problem.find(params[:id])
    @json = @problem.to_gmaps4rails do |problem, marker|
      marker.picture({
                :picture => "/assets/markers/#{problem.ptype}.png",
                :width   => 32,
                :height  => 35
                 })
      marker.title   "#{problem.description}"
      marker.json({ :id => problem.id})
    end
  end

#Show list of reports and show all of them in gmap
  def index
    @problems = Problem.paginate(page: params[:page])
    @json = Problem.all.to_gmaps4rails do |problem, marker|
      marker.picture({
                :picture => "/assets/markers/#{problem.ptype}.png",
                :width   => 32,
                :height  => 35
                 })
      marker.title   "#{problem.description}"
      marker.json({ :id => problem.id})
    end
  end

  def create
    @problem = Problem.new(params[:problem])
#Para obtener el usuario actual que está creando el reporte sólo funciona
#por webapp. Su motivo aplicar relación belongs_to de "problems"

#This works only for dev purposes for submitting reports from the web application 
#and set the curret_user as the reporting, if the submitting problem has no id
#assing the current_user as owner.
    if !@problem.user_id
      @problem.user_id = current_user.id
    end
#Geocoding addresses to coordinates does not work well in Puerto Rico hence its implementationwill be postponed or abandoned
   #@geocoded = Gmaps4rails.geocode(@problem.address)
   #puts @geocoded

#When report is first created, its status is initially Unassigned, hence it is set to 1
    @problem.status = 1
    if @problem.save
      flash[:success] = "Report saved"
      #@lists.problems.create(attributes={"list_id" =>3, "problem_id" => @problem.id})
      redirect_to @problem
    else
      flash.now[:error] = 'Incorrect information'
      redirect_to problems_url
    end
  end

  def destroy
    Problem.find(params[:id]).destroy
    flash[:success] = "Report deleted."
    redirect_to problems_url
  end

  #Before_filter for these methods edit/update to confirm the user is the owner of these reports
  #as in user.rb, rails tutorial
  def edit
    @problem = Problem.find(params[:id])
  end

  def update
    @problem = Problem.find(params[:id])
    if @problem.update_attributes(params[:problem])
      flash[:success] = "Report updated"
      redirect_to @problem
    else
      flash[:error] = "Report update error"
      render 'edit'
    end
  end

  def add_new_comment
    @problem = Problem.find(params[:id])
    @comment = Comment.build_from( @problem, current_user.id, params[:comment][:body] )
    @comment.save!
    flash[:notice] = "Comment added!"
    redirect_to :action => :show, :id => @problem
  end

  def delete_comment
      @problem = Problem.find(params[:id])
      @comment = Comment.find(params[:comment])

      if current_user.id == @comment.user_id
          @comment.destroy
          flash[:notice] = "Comment deleted!"
      else
          flash[:notice] = "Sorry, you can't delete this comment"
      end
      redirect_to :action => :show, :id => @problem
  end

  @type1 = Problems.where(:p_type => 1).count
  @type2 = Problems.where(:p_type => 2).count
  @type3 = Problems.where(:p_type => 3).count
  @type4 = Problems.where(:p_type => 4).count
  @type5 = Problems.where(:p_type => 5).count
  @type6 = Problems.where(:p_type => 6).count
  @type7 = Problems.where(:p_type => 7).count
  @type8 = Problems.where(:p_type => 8).count


#Parameters: {"utf8"=>"√", "authenticity_token"=>"yuxdf1QkhDuuRnAV+qVSTjt0aq3Yo1sW9UN685GhEMc=", 
#  "problem"=>{"user"=>"7876483097", "latitude"=>"18.378383", "longitude"=>"-67.026201", "ptype"=>"2", 
#    "description"=>"Poste roto"}, "commit"=>"Guardar problema"}
end