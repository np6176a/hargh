source "https://rubygems.org"
ruby "2.4.3"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "dotenv-rails-safe", git: "https://github.com/rvirani1/dotenv-rails-safe.git", tag: "v0.3.0"
gem "dry-validation"
gem "jbuilder"
gem "light-service"
gem "pg"
gem "pry-inline"
gem "pry-rails"
gem "puma"
gem "rails"
gem "stronger_parameters"

group :development, :test do
  gem "dotenv-rails"
  gem "rspec_api_documentation"
end

group :development do
  gem "annotate"
  gem "brakeman"
  gem "license_finder"
  gem "mdl"
  gem "overcommit"
  gem "rails_best_practices"
  gem "rubocop"
  gem "spring"
end

group :test do
  gem "factory_bot_rails"
  gem "faker"
  gem "rspec-rails"
  gem "shoulda-matchers"
  gem "simplecov", require: false
end
