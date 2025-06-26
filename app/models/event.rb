# == Schema Information
#
# Table name: events
#
#  id               :bigint           not null, primary key
#  date             :date
#  description      :text
#  google_form_url  :string
#  location         :string
#  result_published :boolean          default(FALSE), not null
#  title            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Event < ApplicationRecord

  has_many :results
  has_many :error_logs
end
