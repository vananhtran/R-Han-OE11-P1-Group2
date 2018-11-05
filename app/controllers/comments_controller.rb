class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  def create
    @comment = Comment.new comment_params
    @mangak = @comment.mangak
    if @comment.save
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".error"
    end
     redirect_to @mangak
  end

  def destroy
    @comment.destroy
    flash[:success] = t ".comment_deleted"
    redirect_to request.referrer || @mangak
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :mangak_id)
  end

  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to @mangak if @comment.nil?
  end
end