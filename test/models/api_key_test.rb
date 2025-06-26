# == Schema Information
#
# Table name: api_keys
#
#  id           :bigint           not null, primary key
#  last_used_at :datetime
#  revoked      :boolean          default(FALSE), not null
#  token        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_api_keys_on_revoked  (revoked)
#  index_api_keys_on_token    (token) UNIQUE
#  index_api_keys_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require "test_helper"

class ApiKeyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
