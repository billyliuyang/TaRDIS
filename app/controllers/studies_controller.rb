class StudiesController < ApplicationController

  before_action :authenticate_user!
  before_action :verify_manager_admin

  include CurrentTimeManagement

  before_action :set_time_management, only: [:index]
  before_action :set_study, only: [:show, :edit, :update, :destroy]
  helper_method :current_user

  def current_user=(user)
    @current_user ||= user 
  end

  # GET /studies
  def index

    # # if a month is selected from the report dropdown, store the value
    # if params[:selected_month]
    #   @month = params[:selected_month]
    #   @month_duration = @time_management.year * 12 + @month.to_i
    # else
    #   # if no month selected on the report dropdown, redirect to the current month
    #   @month = Date.today.month
    #   @month_duration = @month.year * 12 + @month
    #   redirect_to "/studies?selected_month=" + @month.to_s
    # end
    
    @current_nav_identifier = :home
    @study = Study.new
    # @studies = Study.all
    @studies = Study.order(:startdate)
    @time_management = TimeManagement.find(session[:time_management_id])
    @staffs = Staff.order(:grade)

    reporttasks = Array.new
    (1..12).each do |month|
      month_duration = @time_management.year * 12 + month.to_i
      selected = Task.where('(extract(year from startdate) * 12) + extract(month from startdate) <= ? AND 
      (extract(year from enddate) * 12) + extract(month from enddate) >= ? ', month_duration , month_duration)
      reporttasks.push(selected)
    end
    @report_tasks = reporttasks
    # find Task that starts at the same year as the current year & month on the gantt chart
    

  end

  # GET /studies/1
  def show
  end

  # GET /studies/new
  def new
    @study = Study.new
    render layout: false
  end

  # GET /studies/1/edit
  def edit
    render layout: false
  end

  # POST /studies
  def create
    @study = Study.new(study_params)

    if @study.save
      redirect_to "/", notice: 'Study was successfully created.'
    else
      redirect_to "/", alert: @study.errors.full_messages.to_sentence
    end
  end

  # PATCH/PUT /studies/1
  def update
    if @study.update(study_params)
      # redirect_to @study, notice: 'Study was successfully updated.'
      redirect_to "/", notice: 'Study was successfully updated.'
    else
      redirect_to "/", alert: @study.errors.full_messages.to_sentence
      # render :edit
    end
  end

  # DELETE /studies/1
  def destroy
    @study.destroy
    redirect_to "/", notice: 'Study was successfully destroyed.'
  end

  private

    def verify_manager_admin
      raise CanCan::AccessDenied unless current_user.manager? || current_user.admin?
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_study
      @study = Study.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def study_params
      params.require(:study).permit(:title, :startdate, :enddate, :description)
    end
end
