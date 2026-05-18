class NotificationsController < ApplicationController
  before_action :set_notification, only: :mark_as_read

  def index
  end

  def mark_as_read
    @notification.mark_as_read!

    respond_to do |format|
      format.html { redirect_to root_path }
      format.turbo_stream
    end
  end

  def mark_all_as_read
    current_user.received_notifications.unread.update_all(read_at: Time.current)
  end

  private

  def set_notification
    @notification = current_user.received_notifications.find(params[:id])
  end
end
