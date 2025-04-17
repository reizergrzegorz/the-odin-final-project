class FollowRequest < ApplicationRecord
  belongs_to :requester, class_name: "User"
  belongs_to :receiver, class_name: "User"

  STATUSES = %w[pending accepted rejected]

  validates :status, inclusion: { in: STATUSES }
  validates :requester_id, uniqueness: { scope: :receiver_id, message: "Already sent" }
end

