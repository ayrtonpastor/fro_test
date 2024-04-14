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

class Feature < ApplicationRecord
  include StandardServicesImplemented

  has_many :comments, class_name: 'Comment', foreign_key: :feature_id, dependent: :destroy

  validates :external_id, presence: true, uniqueness: { case_sensitive: false }
  validates :title, presence: true
  validates :external_url, presence: true
  validates :place, presence: true
  validates :mag_type, presence: true

  validates :magnitude, presence: true
  validates :magnitude, numericality: { greater_than_or_equal_to: -1.0, less_than_or_equal_to: 10.0 }

  validates :latitude, presence: true
  validates :latitude, numericality: { greater_than_or_equal_to: -90.0, less_than_or_equal_to: 90.0 }

  validates :longitude, presence: true
  validates :latitude, numericality: { greater_than_or_equal_to: -180.0, less_than_or_equal_to: 180.0 }
end
