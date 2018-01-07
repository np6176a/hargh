require "rails_helper"

describe Entry, type: :model do
  subject { build(:entry) }

  it { should belong_to(:har).inverse_of(:entries) }

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

  it "should have a valid factory" do
    expect(subject).to be_valid
  end
end
