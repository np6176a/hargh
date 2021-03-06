require "acceptance_helper"
require_relative "../../app/views/hars/show_jbuilder_schema"

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

  get "/hars/:id" do
    with_options scope: :har do
      har_response_fields
    end

    example "/hars/:id - GET - Success" do
      explanation "Allows you to retrieve a Har"
      har = create(:har)
      do_request(
        id: har.id
      )
      expect(status).to eq(200)
      json = JSON.parse(response_body).with_indifferent_access
      expect(json.dig(:har, :id)).to eq(har.id)
      schema = ShowJbuilderSchema.call(json)
      expect(schema.success?).to eq(true)
    end
  end

  patch "/hars/:id" do
    with_options scope: :har do
      har_response_fields
    end

    example "/hars/id - PATCH - Success" do
      explanation "Allows you update and replace a HAR. Parameters should just be the data of the HAR"
      har = create(:har)
      comment = "Changed Comment"
      patch_data = SAMPLE_RAW_DATA.merge(id: har.id)
      patch_data[:log][:comment] = comment
      do_request(patch_data)
      expect(status).to eq(200)
      json = JSON.parse(response_body).with_indifferent_access
      expect(json.dig(:har, :raw, :log, :comment)).to eq(comment)
      schema = ShowJbuilderSchema.call(json)
      expect(schema.success?).to eq(true)
    end
  end

  delete "/hars/:id" do
    example "/hars/:id - DELETE - Success" do
      explanation "Allows you to delte a HAR"
      har = create(:har)
      do_request(id: har.id)
      expect(status).to eq(204)
      expect(Har.find_by_id(har.id)).to be_nil
    end
  end
end
