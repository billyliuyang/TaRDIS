class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :assign_staff]

  # GET /tasks
  def index
    # @tasks = Task.all
    @tasks = Task.order(:id)
    # render :js => "window.location.href = '/cart';"
  end

  # GET /tasks/1
  def show
  end

  # GET /tasks/new
  def new
    @study = Study.find(params[:study_id])
    @task = Task.new(study_id: @study)
    render layout: false
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
    allocated_staffs = []
    @task.line_staffs.each do |staff|
      allocated_staffs << staff.staff.staffgivenname
    end
    @names = allocated_staffs
    @staffs = Staff.all
    render layout: false
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    if @task.save
      study = Study.find(task_params[:study_id])

      if @task.enddate > study.enddate
        study.enddate = @task.enddate
        study.save
      end

      if @task.startdate < study.startdate
        study.startdate = @task.startdate
        study.save
      end
      
      redirect_to "/", notice: 'Task was successfully created.'
    else
      redirect_to "/", alert: @task.errors.full_messages.to_sentence
    end

  end

  # PATCH/PUT /tasks/1
  def update

    if @task.update(task_params)
      study = Study.find(task_params[:study_id])

      if @task.enddate > study.enddate
        study.enddate = @task.enddate
        study.save
      end
      if @task.startdate < study.startdate
        study.startdate = @task.startdate
        study.save
      end

      redirect_to "/", notice: 'Task was successfully updated.'
    else
      redirect_to "/", alert: @task.errors.full_messages.to_sentence
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    # redirect_to tasks_url, notice: 'Task was successfully destroyed.'
    redirect_to '/', notice: 'Task was successfully destroyed.'
  end

  def assign_staff
    allocated_staffs = []
    @task.line_staffs.each do |staff|
      allocated_staffs << staff.staff.name
    end
    @names = allocated_staffs
    @staffs = Staff.all
    render layout: false
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:title, :startdate, :enddate, :lead_dm_time, :dm_time, :support_dm_time, :study_id)
    end
end
