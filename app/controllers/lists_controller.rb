class ListsController < ApplicationController

def new
    @list = List.new
    @problems= Problem.all
  end

#Show report details and only show selescted problem in gmap
  def show
    @list = List.find(params[:id])
  end

#Show list of reports and show all of them in gmap
  def index
    @lists = List.paginate(page: params[:page])
  end

  def create
    @list = List.new(params[:list])
    #Para obtener el usuario actual que esta creando el reporte solo funciona
    #por webapp. Su motivo aplicar relación belongs_to de "problems"
    @list.user_id = current_user.id
    if @list.save
      flash[:success] = "Lista guardada"
      redirect_to @list
    else
      flash.now[:error] = 'Informacion incorrecta'
      render 'new' 
    end
  end

  def destroy
    List.find(params[:id]).destroy
    flash[:success] = "Lista borrada."
    redirect_to lists_url
  end

  def update
        if @list.update_attributes(params[:list])
      flash[:success] = "Lista actualizada"
      redirect_to @list
    else
      render 'edit'
    end
  end

  #Sólo debería ver los reportes que él ha sometido?
  def candidate_problems
    Problem.find(:all)
  end

  def show_problems
    @list = List.find(params[:id])
  end

  def in_list?(problem)
    problems.include?(problem)
  end

  def save
  @list = List.find(params[:id])
  @problem = Problem.find(params[:problem])
  if params[:show] == "true"
    @list.problems << @problem
  else
    @list.problems.delete(@problem)
  end
  @list.save!
  render :nothing => true
end

end