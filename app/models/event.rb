# == Schema Information
#
# Table name: events
#
#  id               :bigint           not null, primary key
#  description      :text
#  end_date         :date             not null
#  google_form_url  :string
#  location         :string
#  result_published :boolean          default(FALSE), not null
#  start_date       :date             not null
#  title            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Event < ApplicationRecord

  has_many :results
  has_many :error_logs
  has_one_attached :cover_image
  has_many_attached :gallery_images


  validates :title, :start_date, :end_date, presence: true
end
