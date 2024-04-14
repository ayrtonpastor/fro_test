# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :text(65535)
#  feature_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ApplicationRecord
  include StandardServicesImplemented

  belongs_to :feature, class_name: 'Feature', foreign_key: :feature_id

  strip_attributes only: %i[body]

  validates :body, presence: true

  default_scope { order(created_at: :desc) }
end
