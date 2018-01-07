class Hars::CreateHar
  extend LightService::Organizer

  def self.call(params:)
    with(
      params: params
    ).reduce(
      Hars::CreateHar::ValidateSchema,
      Hars::CreateHar::BuildHar,
      Hars::CreateHar::BuildEntries,
      Hars::CreateHar::SaveHar
    )
  end
end
