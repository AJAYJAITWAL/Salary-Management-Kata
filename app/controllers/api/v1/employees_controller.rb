module Api
  module V1
    class EmployeesController < ApplicationController
      before_action :set_employee, only: %i[show update destroy salary]

      def index
        employees = Employee.all
        render json: employees, status: :ok
      end

      def show
        render json: @employee, status: :ok
      end

      def create
        employee = Employee.create!(employee_params)
        render json: employee, status: :created
      end

      def update
        @employee.update!(employee_params)
        render json: @employee, status: :ok
      end

      def destroy
        @employee.destroy!
        head :no_content
      end

      def salary
        result = Payroll::SalaryCalculator.new(@employee).call

        render json: {
          gross: result[:gross].to_s,
          tds: result[:tds].to_s,
          net: result[:net].to_s
        }, status: :ok
      end

      private

      def set_employee
        @employee = Employee.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Employee not found" }, status: :not_found
      end

      def employee_params
        params.require(:employee).permit(:full_name, :job_title, :country, :salary)
      end
    end
  end
end
