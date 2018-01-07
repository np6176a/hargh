class HarsController < ApplicationController
  def create
    # Note: We are going to validate the schema ourselves instead of using Rails Strong Params
    result = Hars::CreateHar.call(params: params.to_unsafe_h)
    if result.success?
      @har = result.har
      render :show
    else
      render_error(msg: result.message, code: result.error_code, status: 400)
    end
  end

  def show
    @har = current_har
  end

  def update
    # Note: We are going to validate the schema ourselves instead of using Rails Strong Params
    result = Hars::UpdateHar.call(har: current_har, params: params.to_unsafe_h)
    if result.success?
      @har = result.har
      render :show
    else
      render_error(msg: result.message, code: result.error_code, status: 400)
    end
  end

  private

  def current_har
    Har.find(params[:id])
  end
end
