require "acceptance_helper"

resource "Entries" do
  get "/hars/:har_id/entries" do
    parameter :direction, "Direction (Must be 'asc' or 'desc')"
    parameter :limit, "Limit"
    parameter :offset, "Offset"
    parameter :url, "URL or fragment to search on"
    parameter :sort, "Columns to sort on (Must be one of #{Entry.column_names.join(', ')})"

    with_options scope: :entries do
      entry_response_fields
    end

    example "/hars/:har_id/entries - GET - Success" do
      explanation "Allows you to search entries"
      entry = create(:entry)
      do_request(
        har_id: entry.har_id
      )
      expect(status).to eq(200)
      json = JSON.parse(response_body).with_indifferent_access
      expect(json.fetch(:entries).size).to eq(1)
      result_entry = json[:entries].first
      expect(result_entry[:id]).to eq(entry.id)
    end
  end

  get "/hars/:har_id/entries/aggregations" do
    parameter :column_name, "Columns to perform the aggregation on (Must be one of #{Entry::NUMERICAL_COLUMNS.join(', ')})"
    parameter :limit, "Limit"
    parameter :offset, "Offset"
    parameter :operation, "Operation (Must be one of 'sum' or 'average')"
    parameter :url, "URL or fragment to search on"

    response_field :value, "Value"

    example "/hars/:har_id/entries/aggregations - GET - Success" do
      explanation "Allows you to sum and average values across numerical columns"
      har     = create(:har)
      entries = create_list(:entry, 2, har_id: har.id, timings_dns: 2)
      do_request(
        har_id:      har.id,
        operation:   "sum",
        column_name: "timings_dns"
      )
      expect(status).to eq(200)
      json     = JSON.parse(response_body).with_indifferent_access
      actual   = json.fetch(:value).to_f
      expected = entries.map(&:timings_dns).sum.to_f
      expect(actual).to eq(expected)
    end
  end
end
