require "rails_helper"

describe Hars::CreateHar do
  let(:data) { SAMPLE_RAW_DATA }

  it "creates a Har and Associated Entries" do
    expect do
      result = described_class.call(params: data)
      har    = result.fetch(:har)
      expect(result.params).to eq(data)
      expect(har.raw).to eq(data)
      expect(har.entries.count).to eq(15)
    end.to change { Har.count }.by(1)
      .and change { Entry.count }.by(15)
  end
end

# TODO: Write tests for each action inside of Har::CreateHar
