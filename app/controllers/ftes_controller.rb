class FtesController < ApplicationController 
  before_action :set_fte, only: [:show, :edit, :update, :destroy]

  # GET /ftes
  def index
    # @ftes = Fte.all
    @ftes = Fte.order(:startdate)
  end

  # GET /ftes/1
  def show
  end

  # GET /ftes/new
  def new
    @staff = Staff.find(params[:staff_id])
    @fte = Fte.new(staff_id: @staff)
    render layout: false
  end

  # GET /ftes/1/edit
  def edit
    render layout: false
  end

  # POST /ftes
  def create
    @fte = Fte.new(fte_params)

    if @fte.save
      redirect_to "/staffs", notice: 'FTE was successfully created.'
    else
      redirect_to "/staffs", alert: @fte.errors.full_messages.to_sentence
    end
  end

  # PATCH/PUT /ftes/1
  def update
    if @fte.update(fte_params)
      redirect_to "/staffs", notice: 'FTE was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /ftes/1
  def destroy
    @fte.destroy
    redirect_to "/staffs", notice: 'FTE was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fte
      @fte = Fte.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def fte_params
      params.require(:fte).permit(:FTE_value, :startdate, :enddate, :staff_id)
    end
end
