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
end
