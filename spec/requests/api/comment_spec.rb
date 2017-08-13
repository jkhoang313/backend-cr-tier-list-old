require 'rails_helper'

RSpec.describe "Tier List API", :type => :request do
  include TestDataHelper

  let!(:user_1) { create_user }
  let!(:user_2) { create_user }
  let!(:tier_list) { TierList.create(creator: user_1) }
  let!(:comment_1) { Comment.create(tier_list: tier_list, commenter: user_1, message: "First Comment", upvotes: -2) }
  let!(:comment_2) { Comment.create(tier_list: tier_list, commenter: user_2, message: "Second Comment", upvotes: 10) }
  let!(:child_comment) { Comment.create(parent_comment: comment_1, commenter: user_2, message: "Child Comment") }

  describe 'GET /api/tier_lists/:id/comments' do
    it 'should return an array of comments' do
      get("/api/tier_lists/#{tier_list.id}/comments")

      body = JSON.parse(response.body)

      expect(body['comments'].length).to eq(2)
      expect(body["comments"][0]["message"]).to eq(comment_1.message)
      expect(body["comments"][0]["upvotes"]).to eq(comment_1.upvotes)
      expect(body["comments"][0]["children_comments"].length).to eq(1)
      expect(body["comments"][0]["children_comments"][0]["message"]).to eq(child_comment.message)
      expect(body["comments"][0]["commenter"]["id"]).to eq(user_1.id)
      expect(body["comments"][0]["commenter"]["user_name"]).to eq(user_1.user_name)
      expect(body["comments"][1]["message"]).to eq(comment_2.message)
      expect(body["comments"][1]["upvotes"]).to eq(comment_2.upvotes)
      expect(body["comments"][1]["children_comments"].length).to eq(0)
      expect(body["comments"][1]["commenter"]["id"]).to eq(user_2.id)
      expect(body["comments"][1]["commenter"]["user_name"]).to eq(user_2.user_name)


    end
  end
end
