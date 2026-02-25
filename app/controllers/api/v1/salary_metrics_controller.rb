module Api
  module V1
    class SalaryMetricsController < ApplicationController
      def country
        result = SalaryMetricsQuery.new.by_country(params[:country])

        return render_not_found unless result

        render json: SalaryMetricsSerializer.country(result), status: :ok
      end

      def job_title
        result = SalaryMetricsQuery.new.by_job_title(params[:job_title])

        return render_not_found unless result

        render json: SalaryMetricsSerializer.job_title(result), status: :ok
      end

      private

      def render_not_found
        render json: { error: "No records found" }, status: :not_found
      end
    end
  end
end
