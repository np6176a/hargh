class Entries::Actions::ExecuteAggregation
  extend LightService::Action
  expects :params, :entries_query
  promises :aggregation_value

  executed do |context|
    context.aggregation_value = context.entries_query.calculate(
      context.params.fetch(:operation),
      context.params.fetch(:column_name)
    )
  end
end
