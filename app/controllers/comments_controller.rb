class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.new(comment_params)

    if @comment.save
      redirect_to comments_path
    else
      render :index
    end
  end

  def update
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to comments_path
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
