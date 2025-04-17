class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :profile, dependent: :destroy
  after_create :create_profile
  after_create :send_welcome_email       
  has_many :posts
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :sent_follow_requests, class_name: "FollowRequest", foreign_key: :requester_id, dependent: :destroy
  has_many :received_follow_requests, class_name: "FollowRequest", foreign_key: :receiver_id, dependent: :destroy

  # Akceptowani obserwowani i obserwujący:
  has_many :followings, -> { where(status: "accepted") }, class_name: "FollowRequest", foreign_key: :requester_id
  has_many :followers,  -> { where(status: "accepted") }, class_name: "FollowRequest", foreign_key: :receiver_id

  has_many :accepted_followers, through: :followers, source: :requester
  has_many :accepted_followings, through: :followings, source: :receiver
  
  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_later
  end
  
  def create_profile
    Profile.create(user: self, username: self.email.split("@").first)
  end
end
