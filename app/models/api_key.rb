class ApiKey < ApplicationRecord
  belongs_to :user

  before_validation :generate_token, on: :create

  private

  def generate_token
    self.token ||= SecureRandom.hex(24)
  end
end
