class User < ApplicationRecord
  has_many :user_interests
  has_many :interests, through: :user_interests

  has_many :connections
  has_many :connected_users, through: :connections, source: :connected_user
end
