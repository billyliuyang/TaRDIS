class LineStaffsController < ApplicationController
  before_action :set_line_staff, only: [:show, :edit, :update, :destroy]

  # GET /line_staffs
  def index
    @line_staffs = LineStaff.all
  end

  # GET /line_staffs/1
  def show
  end

  # GET /line_staffs/new
  def new
    @line_staff = LineStaff.new
  end

  # GET /line_staffs/1/edit
  def edit
  end

  # POST /line_staffs
  def create
    @selectedTask = Task.find(params[:task_id])
    staff = Staff.find(params[:staff_id])
    task = Task.find(params[:task_id])

    @line_staff = task.line_staffs.build(staff: staff)
    @line_staff.grade = params[:grade]

    if @line_staff.save
      set_edit_params
      respond_to do |format|
        format.html { redirect_to "/", notice: 'The staff is successfully allocated to the task.' }
        format.js {
          render :template => "tasks/update_form.js.haml"
        }
      end
    else
      redirect_to "/", notice: 'Fail to allocate.'
    end
  end

  # PATCH/PUT /line_staffs/1
  def update
    if @line_staff.update(line_staff_params)
      redirect_to @line_staff, notice: 'Line staff was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /line_staffs/1
  def destroy
    @line_staff.destroy
    @selectedTask = Task.find(params[:task_id])
    set_edit_params
    # redirect_to "/", notice: 'Allocated staff is removed successfully.'
    respond_to do |format|
      format.html { redirect_to "/", notice: 'Allocated staff is removed successfully.' }
      format.js {
        render :template => "tasks/update_form.js.haml"
      }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_staff
      @line_staff = LineStaff.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def line_staff_params
      params.require(:line_staff).permit(:staff_id, :task_id)
    end

    def set_edit_params
      @task = Task.find(params[:task_id])
      allocated_staffs = []
      @task.line_staffs.each do |staff|
        allocated_staffs << staff.staff.staffgivenname
      end
      @names = allocated_staffs
      @staffs = Staff.all
    end
end
