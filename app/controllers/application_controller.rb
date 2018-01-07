class ApplicationController < ActionController::API
  def render_error(error_result:)
    render json: { error: { message: error_result.message, code: error_result.error_code } }, status: 400
  end
end
