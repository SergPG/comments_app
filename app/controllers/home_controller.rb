class HomeController < ApplicationController
  def index
    @users = User.where.not(id: current_user.id)

    @selected_user = if params[:user_id].present?
                        User.find(params[:user_id])
                      else
                        @users.first
                      end

    @comments = fetch_comments

    @notifications = current_user.received_notifications.unread

    @comment = Comment.new
  end

  private

  # def fetch_comments
  #   scope = Comment.includes(:user)
  #                  .where(user: [current_user, @selected_user])
  #                  .order(created_at: :asc)
  #
  #   if params[:q].present?
  #     ids = Comment.search(params[:q]).map(&:id)
  #     scope = scope.where(id: ids)
  #   end
  #
  #   scope
  # end

  def fetch_comments
    scope = Comment.includes(:user).where(user: [current_user, @selected_user])

    if params[:q].present?
      ids = Comment.search(params[:q]).map(&:id)
      scope = scope.where(id: ids)
    end

    scope.order(created_at: :asc)
  end
end
