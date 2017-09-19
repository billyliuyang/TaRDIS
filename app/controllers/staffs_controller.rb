class StaffsController < ApplicationController

  before_action :authenticate_user!
  before_action :verify_manager_admin
  before_action :set_staff, only: [:show, :edit, :update, :destroy]
  
  # GET /staffs
  def index
    @current_nav_identifier = :staff
    # @staffs = Staff.delete_all
    @staffs = Staff.order(:grade).reverse
    @staff = Staff.new
    @users = User.all
  end

  # GET /staffs/1
  def show
  end

  # GET /staffs/new
  def new
    @staff = Staff.new 
    @users = User.all
    render layout: false
  end
  
  # GET /staffs/1/edit
  def edit
    render layout: false
  end

  # POST /staffs
  def create
    @staff = Staff.new(staff_params)
 
    if @staff.save
      # fte = Fte.new(:FTE_value => 0, :startdate => Time.now, :enddate => Time.now, :staff_id => @staff.id)
      # fte.save
      redirect_to "/staffs/", notice: 'Staff was successfully created. Please add FTE value for the new staff in STAFF MANAGEMENT.'
    else
      redirect_to "/staffs/", alert: @staff.errors.full_messages.to_sentence
    end
  end

  # PATCH/PUT /staffs/1
  def update
    if @staff.update(staff_params)
      redirect_to "/staffs/", notice: 'Staff was successfully updated.'
    else
      redirect_to "/staffs/", alert: @staff.errors.full_messages.to_sentence
    end
  end

  # DELETE /staffs/1
  def destroy
    @staff.destroy
    redirect_to staffs_url, notice: 'Staff was successfully destroyed.'
  end

  private

    def verify_manager_admin 
      raise CanCan::AccessDenied unless current_user.admin? || current_user.manager?
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_staff
      @staff = Staff.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def staff_params
      params.require(:staff).permit(:name, :grade, :staffgivenname)
    end
end
