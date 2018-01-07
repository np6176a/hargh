require_relative "../../lib/num_helpers"

describe NumHelpers do
  describe "#handle_negative" do
    it "returns nil if the value is -1" do
      result = described_class.handle_negative(-1)
      expect(result).to eq(nil)
    end

    it "return 0 if the value is 0" do
      result = described_class.handle_negative(0)
      expect(result).to eq(0)
    end

    it "returns the value if it is greater than 0" do
      result = described_class.handle_negative(3)
      expect(result).to eq(3)
    end
  end
end
