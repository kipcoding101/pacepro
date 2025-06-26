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
require "test_helper"

class ResultTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
