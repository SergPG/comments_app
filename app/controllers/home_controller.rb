class HomeController < ApplicationController
  def index
    @users = User.where.not(id: current_user.id)

    @selected_user = if params[:user_id].present?
      User.find(params[:user_id])
    else
      @users.first
    end

    @comments = fetch_comments

    @notifications = current_user.received_notifications
                                 .includes(:actor, :notifiable)
                                 .order(created_at: :desc)
                                 .limit(10)

    @comment = Comment.new
  end

  private

  def fetch_comments
    scope = Comment.includes(:user).where(user: [ current_user, @selected_user ])

    if params[:q].present?
      ids = Comment.search(params[:q]).map(&:id)
      scope = scope.where(id: ids)
    end

    scope.order(created_at: :asc)
  end
end
