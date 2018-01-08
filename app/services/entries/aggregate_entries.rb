class Entries::AggregateEntries
  extend LightService::Organizer

  def self.call(params:)
    with(
      params: params
    ).reduce(
      Entries::Actions::ExecuteSearch,
      Entries::Actions::ExecuteAggregation
    )
  end
end
