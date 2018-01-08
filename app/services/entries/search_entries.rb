class Entries::SearchEntries
  extend LightService::Organizer

  def self.call(params:)
    with(
      params: params.with_indifferent_access
    ).reduce(
      Entries::Actions::ExecuteSearch
    )
  end
end
