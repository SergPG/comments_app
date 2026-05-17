class NotificationsController < ApplicationController
  before_action :set_notification, only: :mark_as_read

  def index
    @notifications = current_user.received_notifications
                                 .includes(:actor, :notifiable)
                                 .order(created_at: :desc)
  end

  def mark_as_read
    @notification.mark_as_read!

    respond_to do |format|
      format.html { redirect_to root_path }
      format.turbo_stream
    end
  end

  private

  def set_notification
    @notification = current_user.received_notifications.find(params[:id])
  end
end
