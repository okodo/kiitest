class CommentsController < ApplicationController

  before_filter :authenticate_user!

  def create
    event = Event.find(params[:event_id])
    comment = event.comments.create(filtered_params.merge(user_id: current_user.id))
    render json: comment, serializer: CommentSerializer
  end

  private

  def filtered_params
    params.require(:comment).permit(:body)
  end

end
