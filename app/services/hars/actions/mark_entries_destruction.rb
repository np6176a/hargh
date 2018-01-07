class Hars::Actions::MarkEntriesDestruction
  extend LightService::Action
  promises :har

  executed do |context|
    context.har.entries.map(&:mark_for_destruction)
  end
end
