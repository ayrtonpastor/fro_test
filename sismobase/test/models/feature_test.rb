# == Schema Information
#
# Table name: features
#
#  id           :bigint           not null, primary key
#  external_id  :string(255)
#  magnitude    :decimal(15, 10)
#  place        :string(255)
#  time         :string(255)
#  tsunami      :boolean          default(FALSE)
#  mag_type     :string(255)
#  title        :string(255)
#  longitude    :decimal(20, 15)
#  latitude     :decimal(20, 15)
#  external_url :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require "test_helper"

class FeatureTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
