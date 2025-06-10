class User < ApplicationRecord
    enum :role, {
    participant: 0,
    admin: 1
  }, default: :participant
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable



  has_many :api_keys, dependent: :destroy

  def generate_api_key!
    api_keys.create!(
      token: SecureRandom.hex(24),
      last_used_at: Time.current
    )
  end

  # Validations
  validates :email, presence: true, uniqueness: true
end
