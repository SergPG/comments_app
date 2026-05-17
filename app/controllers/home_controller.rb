class HomeController < ApplicationController
  def index
    @users = User.all

    @comments = fetch_comments

    @notifications = current_user.received_notifications.unread

    @comment = Comment.new
  end

  private

  def fetch_comments
    if params[:q].present?
      Comment.search(params[:q], sort: ["created_at:desc"])
    else
      Comment.includes(:user).order(created_at: :desc)
    end
  end
end
