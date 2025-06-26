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
require "test_helper"

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
