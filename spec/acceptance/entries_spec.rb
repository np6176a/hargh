require "acceptance_helper"

resource "Entries" do
  get "/hars/:har_id/entries" do
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
    example "/hars/:har_id/entries/aggregations - GET - Success" do
      explanation "Allows you to sum and average values across numerical columns"
      har = create(:har)
      entries = create_list(:entry, 2, har_id: har.id, timings_dns: 2)
      do_request(
        har_id: har.id,
        operation: "sum",
        column_name: "timings_dns"
      )
      expect(status).to eq(200)
      json = JSON.parse(response_body).with_indifferent_access
      actual = json.fetch(:value).to_f
      expected = entries.map(&:timings_dns).sum.to_f
      expect(actual).to eq(expected)
    end
  end
end
