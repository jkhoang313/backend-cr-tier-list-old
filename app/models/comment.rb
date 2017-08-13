class Comment < ApplicationRecord
  belongs_to :tier_list, optional: true
  belongs_to :parent_comment, class_name: 'Comment', optional: true
  belongs_to :commenter, class_name: 'User', foreign_key: 'user_id'

  has_many :children_comments, class_name: 'Comment', foreign_key: 'parent_comment_id'
end
