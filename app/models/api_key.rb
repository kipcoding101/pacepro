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

class ApiKey < ApplicationRecord
  belongs_to :user

  before_validation :generate_token, on: :create

  scope :active, -> { where(revoked: false) }

  validates :token, presence: true, uniqueness: true
  validates :revoked, inclusion: { in: [true, false] }

  def revoke!
    update!(revoked: true)
  end

  private

  def generate_token
    self.token ||= SecureRandom.hex(24)
  end
end
