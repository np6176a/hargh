# == Schema Information
#
# Table name: hars
#
#  id                             :integer          not null, primary key
#  started_date_time              :datetime         not null
#  title                          :string           not null
#  page_timings_on_content_loaded :decimal(, )      not null
#  page_timings_on_load           :decimal(, )      not null
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  raw                            :jsonb
#  entries_count                  :integer          default(0), not null
#
# Indexes
#
#  index_hars_on_entries_count                   (entries_count)
#  index_hars_on_page_timings_on_content_loaded  (page_timings_on_content_loaded)
#  index_hars_on_page_timings_on_load            (page_timings_on_load)
#  index_hars_on_started_date_time               (started_date_time)
#

class Har < ApplicationRecord
  # Associations
  has_many :entries, inverse_of: :har, autosave: true, dependent: :destroy

  # Validations
  validates :started_date_time, presence: true
  validates :title, presence: true
  validates :page_timings_on_content_loaded, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :page_timings_on_load, presence: true, numericality: { greater_than_or_equal_to: 0 }
  # TODO: Add a validation that uses the HarSchema validator to check the data
end
