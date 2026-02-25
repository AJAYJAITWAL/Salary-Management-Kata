module Api
  module V1
    class SalaryMetricsController < ApplicationController
      def country
        result = SalaryMetricsQuery.new.by_country(params[:country])

        return render_not_found unless result

        render json: serialize_country(result), status: :ok
      end

      def job_title
        result = SalaryMetricsQuery.new.by_job_title(params[:job_title])

        return render_not_found unless result

        render json: serialize_job(result), status: :ok
      end

      private

      def serialize_country(result)
        {
          country: result[:country],
          minimum: result[:minimum].to_s,
          maximum: result[:maximum].to_s,
          average: result[:average].to_s
        }
      end

      def serialize_job(result)
        {
          job_title: result[:job_title],
          average: result[:average].to_s
        }
      end

      def render_not_found
        render json: { error: "No records found" }, status: :not_found
      end
    end
  end
end
