class Entries::SearchEntries
  extend LightService::Organizer

  def self.call(params:)
    with(
      params: params
    ).reduce(
      Entries::Actions::ExecuteSearch
    )
  end
end
