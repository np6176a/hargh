class EntriesController < ApplicationController
  def index
    result = Entries::SearchEntries.call(params: index_params)
    if result.success?
      @entries = result.entries_query
    else
      render_error(msg: result.message, code: result.error_code, status: 400)
    end
  end

  def aggregations
    result = Entries::AggregateEntries.call(params: aggregations_params)
    if result.success?
      @aggregation_value = result.aggregation_value
    else
      render_error(msg: result.message, code: result.error_code, status: 400)
    end
  end

  private

  def index_params
    # Check out Stronger Parameters
    # https://github.com/zendesk/stronger_parameters
    params.permit(
      direction: ActionController::Parameters.enum("asc", "desc"),
      har_id:    ActionController::Parameters.id,
      limit:     ActionController::Parameters.integer,
      offset:    ActionController::Parameters.integer,
      url:       ActionController::Parameters.string,
      sort:      ActionController::Parameters.enum(*Entry.column_names)
    )
  end

  def aggregations_params
    params.permit(
      column_name: ActionController::Parameters.enum(*Entry::NUMERICAL_COLUMNS),
      har_id:      ActionController::Parameters.id,
      limit:       ActionController::Parameters.integer,
      offset:      ActionController::Parameters.integer,
      operation: ActionController::Parameters.enum("sum", "average"),
      url:         ActionController::Parameters.string
    )
  end
end
