class NotificationsController < ApplicationController
  def mark_as_read
    notification = Notification.find(params[:id])
    notification.update(read: true)
    redirect_to dashboard_path, notice: "Notificação marcada como lida."
  end
end
