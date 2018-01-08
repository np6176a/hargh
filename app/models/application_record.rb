class ApplicationRecord < ActiveRecord::Base
  include Filterable

  def self.filterable_column_names
    column_names + %w(limit offset)
  end

  self.abstract_class = true
end
