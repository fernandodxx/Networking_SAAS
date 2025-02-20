class Message < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  validates :content, presence: true
  after_create_commit -> { broadcast_append_to "chat_#{chat.id}_messages" }
end
