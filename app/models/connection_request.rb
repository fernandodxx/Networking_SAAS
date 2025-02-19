class ConnectionRequest < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  validates :status, inclusion: { in: %w[pending accepted declined] }

  after_create :notify_receiver

  private

  def notify_receiver
    Notification.create!(
      user: receiver,
      message: "#{sender.name} te enviou um pedido de conexão!"
    )
  end
end
