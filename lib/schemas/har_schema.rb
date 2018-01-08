require "dry/validation"
require_relative "./creator_browser_schema"
require_relative "./headers_query_string_schema"
require_relative "./cookies_schema"
require_relative "./before_after_request_schema"

HarSchema = Dry::Validation.Schema do
  required(:log).schema do
    required(:version).maybe(:str?)
    required(:creator).schema(CreatorBrowserSchema)
    optional(:browser).schema(CreatorBrowserSchema)
    optional(:pages).each do
      schema do
        required(:startedDateTime).filled(:str?) # TODO: Make a custom predicate for ISO8601 format
        required(:id).filled(:str?) # TODO: Need to validate it's unique
        required(:title).filled(:str?)
        required(:pageTimings).schema do
          optional(:onContentLoad) { (int? | float?) & gteq?(-1) }
          optional(:onLoad) { (int? | float?) & gteq?(-1) }
          optional(:comment).str?
        end
        optional(:comment).str?
      end
    end
    required(:entries).each do
      schema do
        optional(:pageref).str? # TODO: Custom validation to make sure it matches a page ID, required if pages exists
        required(:startedDateTime).filled(:str?) # TODO: Make a custom predicate for ISO8601 format
        required(:time) { float? | int? }
        required(:request).schema do
          required(:method).filled(:str?)
          required(:url).filled(:str?)
          required(:httpVersion).str?
          required(:cookies).each { schema(CookiesSchema) }
          required(:headers).each { schema(HeadersQueryStringSchema) }
          required(:queryString).each { schema(HeadersQueryStringSchema) }
          optional(:postData).schema do
            required(:mimeType).str?
            optional(:params).each do
              schema do
                required(:name).str?
                optional(:value).str?
                optional(:fileName).str?
                optional(:contentType).str?
                optional(:comment).str?
              end
            end
            required(:text).str?
            optional(:comment).str?
          end
          required(:headersSize) { int? & gteq?(-1) }
          required(:bodySize) { filled? > int? }
          optional(:comment).str?
        end

        required(:response).schema do
          required(:status).filled(:int?)
          required(:statusText).str?
          required(:httpVersion).str?
          required(:cookies).each { schema(CookiesSchema) }
          required(:headers).each { schema(HeadersQueryStringSchema) }
          required(:content).schema do
            required(:size) { int? | float? }
            optional(:compression) { int? | float? }
            required(:mimeType).str?
            optional(:text).str?
            optional(:encoding).str?
            optional(:comment).str?
          end
          required(:redirectURL).str?
          required(:headersSize) { int? }
          required(:bodySize) { filled? > int? }
          optional(:comment).str?
        end

        required(:cache).schema do
          optional(:beforeRequest).maybe { schema(BeforeAfterRequestSchema) }
          optional(:afterRequest).maybe { schema(BeforeAfterRequestSchema) }
          optional(:comment).str?
        end

        required(:timings).schema do
          optional(:blocked) { (int? | float?) & gteq?(-1) }
          optional(:dns) { (int? | float?) & gteq?(-1) }
          optional(:connect) { (int? | float?) & gteq?(-1) }
          required(:send) { (int? | float?) & gteq?(-1) }
          required(:wait) { (int? | float?) & gteq?(-1) }
          required(:receive) { (int? | float?) & gteq?(-1) }
          optional(:ssl) { (int? | float?) & gteq?(-1) }
          optional(:comment).str?
        end
        optional(:serverIPAddress).str?
        optional(:connection).str?
        optional(:comment).str?
      end
    end
    optional(:comment).str?
  end
end
