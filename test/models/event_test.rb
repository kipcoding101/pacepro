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
require "test_helper"

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
