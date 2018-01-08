require "rails_helper"

describe Entries::AggregateEntries do
  it "Aggregates Entries (sum, mean, etc) and accepts allowed filters" do
    har = create(:har)
    entry_one = create(:entry, timings_blocked: 1, har_id: har.id)
    entry_two = create(:entry, timings_blocked: 3, har_id: har.id)
    result = described_class.call(params: {
                                    har_id: har.id,
                                    column_name: "timings_blocked",
                                    operation: "average"
                                  })
    actual = result.fetch(:aggregation_value)
    expected = [entry_one.timings_blocked, entry_two.timings_blocked].mean
    expect(actual).to eq(expected)
  end
end
