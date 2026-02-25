module Api
  module V1
    class SalaryMetricsController < ApplicationController
      before_action :validate_country_param, only: :country
      before_action :validate_job_title_param, only: :job_title

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

      def validate_country_param
        return if params[:country].present?

        render json: { error: "country parameter is required" }, status: :bad_request
      end

      def validate_job_title_param
        return if params[:job_title].present?

        render json: { error: "job_title parameter is required" }, status: :bad_request
      end

      def render_not_found
        render json: { error: "No records found" }, status: :not_found
      end
    end
  end
end
