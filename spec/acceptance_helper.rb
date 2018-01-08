require "rails_helper"
require "rspec_api_documentation"
require "rspec_api_documentation/dsl"

RspecApiDocumentation.configure do |config|
  config.api_name                = "Hargh API Docs"
  config.format                  = [:html]
  config.curl_host               = ENV.fetch("HOST_API")
  config.request_body_formatter  = :json
  config.docs_dir = Rails.root.join("public", "docs")
end

RSpec.configure do |config|
  config.before(:each) do |spec|
    if spec.metadata[:type].equal? :acceptance
      header "Accept", "application/json"
      header "Content-Type", "application/json"
    end
  end
end
