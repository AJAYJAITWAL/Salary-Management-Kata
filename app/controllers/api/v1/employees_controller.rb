module Api
  module V1
    class EmployeesController < ApplicationController
      before_action :set_employee, only: %i[show update destroy]

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

      private

      def set_employee
        @employee = Employee.find(params[:id])
      end

      def employee_params
        params.require(:employee).permit(:full_name, :job_title, :country, :salary)
      end
    end
  end
end
