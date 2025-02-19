class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_interests, dependent: :destroy
  has_many :interests, through: :user_interests

  has_many :connections
  has_many :connected_users, through: :connections, source: :connected_user
  has_many :connection_requests, foreign_key: :sender_id
  has_many :received_requests, class_name: "ConnectionRequest", foreign_key: :receiver_id
  has_many :notifications, dependent: :destroy

  def suggested_users
  User.where.not(id: self.id)
      .joins(:interests)
      .where(interests: { id: self.interest_ids })
      .distinct
  end
end
