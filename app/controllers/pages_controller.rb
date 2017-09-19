class PagesController < ApplicationController
  include CurrentTimeManagement

  before_action :set_time_management, only: [:home]

  def home
    @current_nav_identifier = :home
    @study = Study.new
    @studies = Study.all
  end
  
end