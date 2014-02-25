class ReportTypesController < ApplicationController


  def new
    @report_type = ReportType.new
    @problems = Problems.all
  end

  def index
    @report_types = ReportType.paginate(page: params[:page])
  end

  def show
    @report_type = ReportType.find(params[:id])
    @problems = Problem.paginate(page: params[:page])
  end

  def create
    @report_type = ReportType.new(params[:report_type])

    if @report_type.save
      flash[:success] = "El nuevo tipo ha sido creado."
      redirect_to reportes_tipos_path
    else
      flash[:error] = 'El nuevo tipo no fue creado.'
      redirect_to  reportes_tipos_path 
    end
  end

  def destroy
    @report_type = ReportType.find(params[:id])

  # Unassign all contained reports unless already resolved
    #@report_type.problems.each do |problem|
        #problem.status = 0
        #problem.save
    #end
    @report_type.destroy
    flash[:success] = "Report type deleted."
    redirect_to reportes_tipos_path
  end

  def edit
    @report_type = ReportType.find(params[:id])
  end

  def update
    @report_type = ReportType.find(params[:id])
      if @report_type.update_attributes(params[:report_type])
        flash[:success] = "Report type updated"
        redirect_to reportes_tipos_path
      else
        flash[:error] = "Report type update error"
        redirect_to reportes_tipos_path
      end
  end
end
