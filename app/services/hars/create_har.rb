class Hars::CreateHar
  extend LightService::Organizer

  def self.call(params:)
    with(
      params: params
    ).reduce(
      Hars::Actions::ValidateSchema,
      Hars::Actions::InitializeHar,
      Hars::Actions::BuildHar,
      Hars::Actions::BuildEntries,
      Hars::Actions::SaveHar
    )
  end
end
