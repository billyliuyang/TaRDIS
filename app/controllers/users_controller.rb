class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :verify_admin
  # before_action :set_user, only: [:show, :edit, :update, :destroy]


  
  # GET /users
  def index
    # @users = User.where("role = ? or role = ?", 0, 1)
    @users = User.order(:role).reverse
  end

  # GET /users/1
  def show
  end

  # GET /users/new
  def new
    # @user = User.new 
    @user = User.new(params[:username])
    render layout: false
    # @user.get_info_from_ldap

    # if @user.save
    #   redirect_to "/users/", notice: 'User was successfully created'
    # else
    #   redirect_to "/users/", notice: 'Failed to add users'
    # end

    # render layout: false
  end

  # GET /users/1/edit
  def edit
    # @users = User.all
    @user = User.find(params[:id])
    render layout: false
  end

  # POST /users
  def create
    @un = params[:account]

    user = User.new(username: @un)
    user.get_info_from_ldap
    if user.save
      staff = Staff.new(:name => user.username, :staffgivenname => user.givenname, :grade => user_params[:grade])
      user.role = 0
      user.save
      if staff.save
        # fte = Fte.new(:FTE_value => 0, :startdate => Time.now, :enddate => Time.now, :staff_id => staff.id)
        # fte.save
        redirect_to "/staffs/", notice: 'User was successfully created.'
      else
        redirect_to "/staffs/", alert: "Failed to add user: username or grade can't be empty"
      end

    else
      redirect_to "/staffs/", alert: "Failed to add user: username or grade can't be empty"
      # render :action => "new"
    end

  end

  # PATCH/PUT /users/1
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to "/users/", notice: 'User was successfully updated.'
    else
      redirect_to "/users/", alert: @user.errors.full_messages.to_sentence
    end
  end

  # DELETE /users/1
  def destroy
    @user = User.find(params[:id])
    if @user.present?
      @user.destroy 
    end
    redirect_to "/users/", notice: 'Staff was successfully destroyed.'
  end

  private

    def verify_admin 
      raise CanCan::AccessDenied unless current_user.admin?
    end

    def user_params
      params.require(:user).permit(:grade, :role)
    end

end
