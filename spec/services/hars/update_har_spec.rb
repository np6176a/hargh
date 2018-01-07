require "rails_helper"

describe Hars::UpdateHar do
  let(:created_har) { create(:har) }
  let(:data) { SAMPLE_RAW_DATA }

  it "updates a Har and Associated Entries" do
    expect do
      comment = "Changed Comment"
      data = SAMPLE_RAW_DATA.deep_dup
      data[:log][:comment] = comment
      data[:log][:entries].pop
      result = described_class.call(har: created_har, params: data)
      created_har.reload
      expect(created_har).to eq(result.fetch(:har))
      expect(created_har.raw).to eq(data)
      expect(created_har.entries.size).to eq(14)
    end.to change { Har.count }.by(0)
      .and change { created_har.updated_at }
  end
end
