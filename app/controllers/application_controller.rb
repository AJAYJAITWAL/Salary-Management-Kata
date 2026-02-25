class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound do
    render json: { error: "Not Found" }, status: :not_found
  end

  rescue_from ActiveRecord::RecordInvalid do |exception|
    render json: { errors: exception.record.errors.full_messages },
           status: :unprocessable_entity
  end
end
