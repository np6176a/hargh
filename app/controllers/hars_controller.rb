class HarsController < ApplicationController
  def create
    result = Hars::CreateHar.call(data: create_params)
    if result.success?
      head :ok
    else
      render_error(error_result: result)
    end
  end

  private

  def create_params
    # TODO: Use stronger parameters here later
    params.to_unsafe_h
  end
end
