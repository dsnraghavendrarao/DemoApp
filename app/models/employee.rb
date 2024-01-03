class Employee < ApplicationRecord
	has_many :contacts
	has_many :salaries
	
	validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
	validates :employee_code, presence: true
  	validates :employee_code_id, presence: true, uniqueness: { scope: :employee_code }
  	before_validation :generate_employee_code, on: :create


	def tax_deductions(year = nil)
	   puts business_year_range(nil)
	   total_amount = self.salaries.where(credit_date: business_year_range(year)).sum(:amount)
	   tax_amount = Salary.calculate_income_tax(total_amount)
	   cess = Salary.cess(total_amount)
	   {gp: total_amount, tax: tax_amount, np: (total_amount - (tax_amount+cess)), cess: cess}
	end

	private

  	def business_year_range(year)
    	current_year = year.nil? ? Time.now.year : year 
    	business_year_start = Date.new(current_year, 4, 1)
    	business_year_end = Date.new((current_year + 1), 3, 31)
    	business_year_start..business_year_end
  	end

  	def generate_employee_code
    	self.employee_code ||= "#{default_code}/#{generate_employee_code_id}" 
    	self.employee_code_id ||= generate_employee_code_id
  	end

  	def generate_employee_code_id
    	last_employee = Employee.where(employee_code: employee_code).order(employee_code_id: :desc).first
    	last_id = last_employee&.employee_code_id || 0
    	last_id + 1
  	end

  	def default_code
  		'EMP'
  	end
end

  

