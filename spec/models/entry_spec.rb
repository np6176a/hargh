require "rails_helper"

describe Entry, type: :model do
  subject { build(:entry) }

  it { should belong_to(:har).inverse_of(:entries).counter_cache(true) }

  it { should validate_presence_of(:started_date_time) }
  it { should validate_presence_of(:time) }
  it { should validate_numericality_of(:time) }
  it { should validate_presence_of(:http_method) }
  it { should validate_presence_of(:url) }
  it { should validate_presence_of(:response_status) }
  it { should validate_numericality_of(:response_status) }
  it { should validate_presence_of(:response_content_size) }
  it { should validate_numericality_of(:response_content_size) }
  it { should validate_presence_of(:raw) }
  it { should validate_presence_of(:har) }

  describe "#url" do
    it "should only include entries with that URL" do
      included_entry = create(:entry, url: "a")
      excluded_entry = create(:entry, url: "b")
      results = described_class.url("a")
      expect(results).to include(included_entry)
      expect(results).not_to include(excluded_entry)
    end
  end

  it "should have a valid factory" do
    expect(subject).to be_valid
  end
end
