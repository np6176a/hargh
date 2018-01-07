require "rails_helper"

describe HarSchema do
  it "is valid for a valid schema" do
    sample_data_schema = described_class.call(SAMPLE_RAW_DATA)
    expect(sample_data_schema.success?).to eq(true)
  end

  it "is invalid if there no log key" do
    sample_data = SAMPLE_RAW_DATA.dup
    sample_data[:loggy] = sample_data.delete(:log)
    sample_data_schema = described_class.call(sample_data)
    expect(sample_data_schema.success?).to eq(false)
  end

  # TODO: Lots of more test cases. Fixtures for valid and invalid schemas make a lot of sense here
end
