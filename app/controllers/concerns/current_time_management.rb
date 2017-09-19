module CurrentTimeManagement
	private
		def set_time_management
			@time_management = TimeManagement.find(session[:time_management_id])
		rescue ActiveRecord::RecordNotFound
			@time_management = TimeManagement.create
			session[:time_management_id] = @time_management.id 
		end
end