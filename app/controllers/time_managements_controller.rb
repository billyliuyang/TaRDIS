class TimeManagementsController < ApplicationController
  before_action :set_time_management, only: [:show, :edit, :update, :destroy]

  # GET /time_managements
  def index
    @time_managements = TimeManagement.all
  end

  # GET /time_managements/1
  def show
  end

  # GET /time_managements/new
  def new
    @time_management = TimeManagement.new
  end

  # GET /time_managements/1/edit
  def edit
  end

  # POST /time_managements
  def create
    @time_management = TimeManagement.new(time_management_params)

    if @time_management.save
      redirect_to @time_management, notice: 'Time management was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /time_managements/1
  def update
    if @time_management.update(time_management_params)
      redirect_to @time_management, notice: 'Time management was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /time_managements/1
  def destroy
    @time_management.destroy
    redirect_to time_managements_url, notice: 'Time management was successfully destroyed.'
  end

  def next_year
    @time_management = TimeManagement.find(session[:time_management_id])
    @time_management.year += 1
    if @time_management.save
      redirect_to "/"
    end
  end

  def last_year
    @time_management = TimeManagement.find(session[:time_management_id])
    @time_management.year -= 1
    if @time_management.save
      redirect_to "/"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_management
      @time_management = TimeManagement.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def time_management_params
      params.require(:time_management).permit(:chart_year)
    end
end
