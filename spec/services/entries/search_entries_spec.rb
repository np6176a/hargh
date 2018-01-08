require "rails_helper"

describe Entries::SearchEntries do
  it "Searches Entries and accepts allowed filters" do
    included_entry_one = create(:entry, url: "aa")
    included_entry_two = create(:entry, url: "ab")
    excluded_entry_one = create(:entry, url: "ac")
    excluded_entry_two = create(:entry, url: "c")
    params = { url: "a", sort: "url", direction: "asc", offset: 0, limit: 2 }
    result = described_class.call(params: params)
    query = result.fetch(:entries_query)
    expect(query).to include(included_entry_one)
    expect(query).to include(included_entry_two)
    expect(query).not_to include(excluded_entry_one)
    expect(query).not_to include(excluded_entry_two)
  end
end
