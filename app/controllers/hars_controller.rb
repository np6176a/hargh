class HarsController < ApplicationController
  def create
    # Note: We are going to validate the schema ourselves instead of using Rails Strong Params
    result = Hars::CreateHar.call(params: params.to_unsafe_h)
    if result.success?
      head :ok
    else
      render_error(error_result: result)
    end
  end
end
