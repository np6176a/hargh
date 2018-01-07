class HarsController < ApplicationController
  def create
    # Note: We are going to validate the schema ourselves instead of using Rails Strong Params
    result = Hars::CreateHar.call(params: params.to_unsafe_h)
    if result.success?
      head :ok
    else
      render_error(msg: result.message, code: result.error_code, status: 400)
    end
  end

  private

  def current_har
    @_har ||= Har.find(params[:id])
  end
  helper_method :current_har
end
