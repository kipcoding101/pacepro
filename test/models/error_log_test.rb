# == Schema Information
#
# Table name: error_logs
#
#  id         :bigint           not null, primary key
#  details    :jsonb
#  message    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_error_logs_on_event_id  (event_id)
#  index_error_logs_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#  fk_rails_...  (user_id => users.id)
#

require "test_helper"

class ErrorLogTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
