class CommentsController < ApplicationController
  def index
    tier_list = TierList.find(params["tier_list_id"])
    comments = tier_list.comments

    render json: { comments: comments.map {|comment| CommentSerializer.new(comment)} }, root: false
  end
end
