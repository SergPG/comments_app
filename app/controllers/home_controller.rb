class HomeController < ApplicationController
  def index
    @users = User.where.not(id: current_user.id)

    @users = User.where.not(id: current_user.id).order(:username)

    @selected_user = User.find_by(id: params[:user_id])

    @comments = fetch_comments

    @notifications = current_user.received_notifications
                                 .includes(:actor, :notifiable)
                                 .order(created_at: :desc)
                                 .limit(10)

    @comment = Comment.new
  end

  private

  def fetch_comments
    scope = Comment.includes(:user)

    scope = scope.where(user: @selected_user) if @selected_user.present?

    if params[:q].present?
      results = Comment.search(params[:q])
      ids = results.map(&:id)

      scope = scope.where(id: ids)
    end

    scope.order(created_at: :desc)
  end
end
