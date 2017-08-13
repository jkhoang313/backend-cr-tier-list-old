class CommentSerializer < ActiveModel::Serializer
  has_one :commenter
  attributes :upvotes, :message, :children_comments

  def children_comments
    object.children_comments.map{|comment| CommentSerializer.new(comment, root: false)}
  end
end
