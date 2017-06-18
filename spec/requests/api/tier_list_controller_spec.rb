require 'rails_helper'

RSpec.describe "Tier List API", :type => :request do
  describe 'GET /api/tier_lists' do
    context 'when list_type is 1' do
      params: {list_type: 1}

      it 'should return all tournament tier lists' do
        get("/api/tier_lists", params: params)

        body = JSON.parse(response.body)

      end
    end
  end
end
