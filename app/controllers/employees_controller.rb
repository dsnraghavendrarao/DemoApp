class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :update, :destroy, :business_year_net_payable]

  # GET /employees
  def index
    @employees = Employee.all

    render json: @employees
  end

  # GET /employees/1
  def show
    render json: @employee
  end

  # POST /employees
  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      render json: @employee, status: :created, location: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /employees/1
  def update
    if @employee.update(employee_params)
      render json: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  # DELETE /employees/1
  def destroy
    @employee.destroy
  end


  def business_year_net_payable
    @year = params[:year]
    render json: {success: false,message: "Invalide Employee"} && return unless employee.present?
    @employee_salary = @employee.tax_deductions(@year)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find_by(params[:id]) || Employee.find_by(employee_code: params[:employee_code])
    end

    # Only allow a list of trusted parameters through.
    def employee_params
      params.require(:employee).permit(:employee_code, :first_name, :last_name, :email, :date_of_join, contacts_attributes: [:id, :phone, :primary])
    end
end
