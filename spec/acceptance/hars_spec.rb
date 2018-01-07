require "acceptance_helper"

resource "Hars" do
  post "/hars" do
    example "/hars - POST - Success" do
      explanation "Parameters are not explicitly listed; however, you should send a valid HAR 1.2 document as the POST params"
      do_request(SAMPLE_RAW_DATA)
      expect(status).to eq(200)
      last_har = Har.last
      expect(last_har.title).to eq(SAMPLE_RAW_DATA_TITLE)
      expect(last_har.page_timings_on_load.to_f.round(4)).to eq(SAMPLE_RAW_DATA_LOAD_TIMING.round(4))
    end
  end
end
