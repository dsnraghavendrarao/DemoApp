class TaxCalcuationsController < ApplicationController
	before_action :employee, only: [:create]
	
	def create
	   render json: {success: false,message: "Invalide Employee"} && return unless employee.present?
	   @salary = Salary.new(salary_params)
	   @salary.employee_id = @employee.id
	   if @salary.save
      	render json: @salary, status: :created, location: @employee
       else
        render json: @salary.errors, status: :unprocessable_entity
       end
	end

	private

	def employee
		@employee ||= Employee.find_by(id: params[:employee_id])
	end

	def salary_params
      params.require(:salary).permit(:employee_id, :amount, :credit_date, :start_date, :end_date)
    end
end
