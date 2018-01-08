require "rails_helper"
require "rspec_api_documentation"
require "rspec_api_documentation/dsl"

RspecApiDocumentation.configure do |config|
  config.api_name                = "Hargh API Docs"
  config.format                  = [:html]
  config.curl_host               = ENV.fetch("HOST_API")
  config.request_body_formatter  = :json
  config.docs_dir = Rails.root.join("public")
end

RSpec.configure do |config|
  config.before(:each) do |spec|
    if spec.metadata[:type].equal? :acceptance
      header "Accept", "application/json"
      header "Content-Type", "application/json"
    end
  end
end

# Response Field Helpers
def har_response_fields(opts = {})
  response_field :created_at, "Created At", opts
  response_field :entries_count, "Number of Entries on this HAR", opts
  response_field :id, "ID", opts
  response_field :page_timings_on_content_loaded, "HAR Page Timings On Content Load", opts
  response_field :page_timings_on_load, "HAR Page Timings On Load", opts
  response_field :raw, "Original Data Sent", opts
  response_field :started_date_time, "HAR Started Date Time", opts
  response_field :title, "HAR Title", opts
end

def entry_response_fields(opts = {})
  response_field :id, "ID", opts
  response_field :raw, "Original Data Sent", opts
  response_field :http_method, "HTTP Method", opts
  response_field :response_content_mime_type, "Response Content Mime Type", opts
  response_field :response_content_size, "Response Content Size", opts
  response_field :response_status, "Response Status", opts
  response_field :started_date_time, "Started Date Time", opts
  response_field :time, "Time", opts
  response_field :timings_blocked, "Timings Blocked", opts
  response_field :timings_connect, "Timings Connect", opts
  response_field :timings_dns, "Timings DNS", opts
  response_field :timings_receive, "Timings Receive", opts
  response_field :timings_send, "Timings Send", opts
  response_field :timings_ssl, "Timings SSL", opts
  response_field :timings_wait, "Timings Wait", opts
  response_field :url, "URL", opts
end
