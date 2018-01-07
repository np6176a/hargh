# == Schema Information
#
# Table name: entries
#
#  id                         :integer          not null, primary key
#  started_date_time          :datetime         not null
#  time                       :decimal(, )
#  http_method                :string           not null
#  url                        :string
#  response_status            :integer
#  response_content_size      :decimal(, )
#  response_content_mime_type :string
#  timings_blocked            :decimal(, )
#  timings_dns                :decimal(, )
#  timings_ssl                :decimal(, )
#  timings_connect            :decimal(, )
#  timings_send               :decimal(, )
#  timings_wait               :decimal(, )
#  timings_receive            :decimal(, )
#  raw                        :jsonb            not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  har_id                     :integer          not null
#
# Indexes
#
#  index_entries_on_har_id                      (har_id)
#  index_entries_on_http_method                 (http_method)
#  index_entries_on_response_content_mime_type  (response_content_mime_type)
#  index_entries_on_response_content_size       (response_content_size)
#  index_entries_on_response_status             (response_status)
#  index_entries_on_started_date_time           (started_date_time)
#  index_entries_on_time                        (time)
#  index_entries_on_timings_blocked             (timings_blocked)
#  index_entries_on_timings_connect             (timings_connect)
#  index_entries_on_timings_dns                 (timings_dns)
#  index_entries_on_timings_receive             (timings_receive)
#  index_entries_on_timings_send                (timings_send)
#  index_entries_on_timings_ssl                 (timings_ssl)
#  index_entries_on_timings_wait                (timings_wait)
#  index_entries_on_url                         (url)
#

class Entry < ApplicationRecord
  serialize :raw

  # Associations
  belongs_to :har, inverse_of: :entries

  # Validations
  validates :started_date_time, presence: true
  validates :time, presence: true, numericality: true
  validates :http_method, presence: true
  validates :url, presence: true
  validates :response_status, presence: true, numericality: true
  validates :response_content_size, presence: true, numericality: true
  validates :raw, presence: true
  validates :time, presence: true, numericality: true
  validates :har, presence: true
end
