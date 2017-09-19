module StudiesHelper

 def working_days_in_month(year,month)
   d = Date.civil(year,month,1)
   (d.beginning_of_month..d.end_of_month).count {|day| !day.saturday? && !day.sunday? && !day.holiday?(:gb)  }
 end

 def working_hours_in_month(year,month)
 	working_days_in_month(year,month) * 7
 end
 
end
