require "rails_helper"

describe Entries::SearchEntries do
  it "Searches Entries and accepts allowed filters" do
    included_entry_one = create(:entry, url: "aa")
    included_entry_two = create(:entry, url: "ab")
    excluded_entry_one = create(:entry, url: "ac")
    excluded_entry_two = create(:entry, url: "c")
    result = described_class.call(params: {
      direction: "asc",
      limit: 2,
      offset: 0,
      sort: "url",
      url: "a"
    }.with_indifferent_access)
    query = result.fetch(:entries_query)
    expect(query).to include(included_entry_one)
    expect(query).to include(included_entry_two)
    expect(query).not_to include(excluded_entry_one)
    expect(query).not_to include(excluded_entry_two)
  end
end
