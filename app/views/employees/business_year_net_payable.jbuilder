json.success true
if @employee.present?
	
	json.(@employee, :employee_code, :first_name, :last_name, :email, :date_of_join, :created_at, :updated_at)
	json.business_year_net_payable  do
		json.gross_pay @employee_salary[:gp]
		json.tax @employee_salary[:tax] 
		json.net_pay @employee_salary[:np]
		json.cess @employee_salary[:cess]
	end
	json.contacts @employee.contacts do |contact|
		json.(contact)
	end
end