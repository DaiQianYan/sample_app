# 13.2 Generating the Micropost model.
class Micropost < ApplicationRecord
  # 13.10 A micropost belongs_to a user.
  belongs_to :user
  # 13.17 Ordering the microposts with default_scope.
  default_scope -> { order(created_at: :desc) }
  # 13.5 A validation for the micropost's user_id.
  validates :user_id, presence: true
  # 13.8 The Micropost model validations.
  validates :content, presence: true, length: { maximum: 140 }
end
