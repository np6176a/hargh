class Hars::UpdateHar
  extend LightService::Organizer

  def self.call(har:, params:)
    with(
      har: har,
      params: params
    ).reduce(
      Hars::Actions::ValidateSchema,
      Hars::Actions::BuildHar,
      Hars::Actions::MarkEntriesDestruction,
      Hars::Actions::BuildEntries,
      Hars::Actions::SaveHar
    )
  end
end
