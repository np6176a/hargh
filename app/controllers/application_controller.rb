class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def handle_invalid_record(error)
    render_error(msg: error.record.full_messages, code: 1001, status: 400)
  end

  def handle_not_found
    render_error(msg: "Not Found", code: 1004, status: 404)
  end

  def render_error(msg: nil, code: nil, status: 400)
    render json: { error: { message: msg, code: code } }, status: status
  end
end
