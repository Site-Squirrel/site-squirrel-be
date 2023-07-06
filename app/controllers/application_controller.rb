class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_invalid_response

  def render_invalid_response(exception)
    render json: ErrorSerializer.new(exception.message).invalid_request, status: 400
  end
end
