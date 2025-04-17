class FollowRequest < ApplicationRecord
  belongs_to :requester, class_name: "User"
  belongs_to :receiver, class_name: "User"

  STATUSES = %w[pending accepted rejected]

  validates :status, inclusion: { in: STATUSES }
  validates :requester_id, uniqueness: { scope: :receiver_id, message: "Already sent" }

  validate :requester_cannot_follow_themselves

  def requester_cannot_follow_themselves
    if requester_id == receiver_id
      errors.add(:receiver_id, "can't be the same as requester")
    end
  end
end

