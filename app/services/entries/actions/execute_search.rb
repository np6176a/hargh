class Entries::Actions::ExecuteSearch
  extend LightService::Action
  expects :params
  promises :entries_query

  executed do |context|
    filterable_params = context.params.slice(*Entry.filterable_column_names)
    context.entries_query = Entry
      .filter(filterable_params)
      .order("#{sort_column(context.params)} #{sort_direction(context.params)} NULLS LAST")
  end

  def self.sort_column(params)
    params[:sort] || :id
  end

  def self.sort_direction(params)
    params[:direction] || :asc
  end
end
