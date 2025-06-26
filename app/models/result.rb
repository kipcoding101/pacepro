# == Schema Information
#
# Table name: results
#
#  id         :bigint           not null, primary key
#  raw_data   :jsonb            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :bigint           not null
#
# Indexes
#
#  index_results_on_event_id  (event_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#
# app/models/result.rb
class Result < ApplicationRecord
  belongs_to :event

  validates :raw_data, presence: true

  def [](key)
    raw_data[key.to_s]
  end

  def finish_time_seconds
    time_str = raw_data['FinishTime']
    return unless time_str

    parts = time_str.split(':').map(&:to_f)
    parts.reverse_each.with_index.sum { |value, idx| value * (60**idx) }
  end
end