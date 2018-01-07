# == Schema Information
#
# Table name: hars
#
#  id                         :integer          not null, primary key
#  started_date_time            :datetime         not null
#  title                      :string           not null
#  page_timings_on_content_loaded :decimal(, )      not null
#  page_timings_on_load          :decimal(, )      not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

require "rails_helper"

describe Har, type: :model do
  subject { build(:har) }

  it { should have_many(:entries).inverse_of(:har).autosave(true).dependent(:destroy) }

  it { should validate_presence_of(:started_date_time) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:page_timings_on_content_loaded) }
  it { should validate_numericality_of(:page_timings_on_content_loaded).is_greater_than_or_equal_to(0) }
  it { should validate_presence_of(:page_timings_on_load) }
  it { should validate_numericality_of(:page_timings_on_load).is_greater_than_or_equal_to(0) }

  it "should have a valid factory" do
    expect(subject).to be_valid
  end
end
