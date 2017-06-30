require 'rails_helper'

RSpec.describe "Tier List API", :type => :request do
  include TestDataHelper
  let!(:user) { create_user }
  let!(:tournament_lists) { create_tournament_lists }
  let!(:ladder_lists) { create_ladder_lists }

  describe 'GET /api/tier_lists' do
    context 'when list_type is 1' do
      let!(:params) { {list_type: 1} }

      it 'should return all tournament tier lists' do
        get("/api/tier_lists", params: params)

        list_1 = tournament_lists[0]
        list_2 = tournament_lists[1]

        body = JSON.parse(response.body)

        expect(body["tier_lists"].length).to eq(2)
        expect(body["tier_lists"][0]["name"]).to eq(list_1.name)
        expect(body["tier_lists"][0]["description"]).to eq(list_1.description)
        expect(body["tier_lists"][0]["upvotes"]).to eq(list_1.upvotes)
        expect(body["tier_lists"][1]["name"]).to eq(list_2.name)
        expect(body["tier_lists"][1]["description"]).to eq(list_2.description)
        expect(body["tier_lists"][1]["upvotes"]).to eq(list_2.upvotes)
      end
    end

    context 'when list_type is 2' do
      let!(:params) { {"list_type" => 2} }

      it 'should return all ladder tier lists' do
        get("/api/tier_lists", params: params)

        list_1 = ladder_lists[0]
        list_2 = ladder_lists[1]

        body = JSON.parse(response.body)

        expect(body["tier_lists"].length).to eq(2)
        expect(body["tier_lists"][0]["name"]).to eq(list_1.name)
        expect(body["tier_lists"][0]["description"]).to eq(list_1.description)
        expect(body["tier_lists"][0]["upvotes"]).to eq(list_1.upvotes)
        expect(body["tier_lists"][1]["name"]).to eq(list_2.name)
        expect(body["tier_lists"][1]["description"]).to eq(list_2.description)
        expect(body["tier_lists"][1]["upvotes"]).to eq(list_2.upvotes)
      end
    end
  end

  describe 'GET /api/tier_lists/:id' do
    it 'return the selected tier list' do
      get("/api/tier_lists/#{tournament_lists[0].id}")

      body = JSON.parse(response.body)

      expect(body["tier_list"]["name"]).to eq(tournament_lists[0].name)
      expect(body["tier_list"]["description"]).to eq(tournament_lists[0].description)
      expect(body["tier_list"]["upvotes"]).to eq(tournament_lists[0].upvotes)
    end
  end

  describe 'POST /api/tier_lists' do
    let!(:params) {{
      "user_id" => user.id,
      "name" => "newly created tier list",
      "list_type" => 1,
      "description" => "new description"
    }}

    it 'create a tier list with the correct params' do
      post("/api/tier_lists", params: params)

      body = JSON.parse(response.body)

      newest_tier_list = TierList.last

      expect(body["tier_list"]["name"]).to eq(params["name"])
      expect(body["tier_list"]["list_type"]).to eq(params["list_type"])
      expect(body["tier_list"]["description"]).to eq(params["description"])

      expect(body["tier_list"]["name"]).to eq(newest_tier_list.name)
      expect(body["tier_list"]["description"]).to eq(newest_tier_list.description)
      expect(body["tier_list"]["upvotes"]).to eq(newest_tier_list.upvotes)
    end
  end

  describe 'PUT /api/tier_lists/:id' do
    let!(:params) {{
      "name" => "updated name",
      "list_type" => 3,
      "description" => "updated description",
      "update_upvotes" => 1
    }}
    let!(:params_downvote) {{
      "update_upvotes" => -2
    }}

    it 'can update a tier list\'s name and description' do
      put("/api/tier_lists/#{tournament_lists[0].id}", params: params)
      body = JSON.parse(response.body)

      updated_tier_list = tournament_lists[0].reload

      expect(body["tier_list"]["name"]).to eq(params["name"])
      expect(body["tier_list"]["description"]).to eq(params["description"])

      expect(updated_tier_list.name).to eq(params["name"])
      expect(updated_tier_list.description).to eq(params["description"])
    end

    it 'can upvote a tier list' do
      put("/api/tier_lists/#{tournament_lists[0].id}", params: params)
      body = JSON.parse(response.body)

      expect(body["tier_list"]["upvotes"]).to eq(tournament_lists[0].upvotes + params["update_upvotes"])

      expect(body["tier_list"]["upvotes"]).to eq(tournament_lists[0].reload.upvotes)
    end

    it 'can downvote a tier list' do
      put("/api/tier_lists/#{tournament_lists[0].id}", params: params_downvote)
      body = JSON.parse(response.body)

      expect(body["tier_list"]["upvotes"]).to eq(tournament_lists[0].upvotes + params_downvote["update_upvotes"])

      expect(body["tier_list"]["upvotes"]).to eq(tournament_lists[0].reload.upvotes)
    end

    it 'can add a new tier' do
    end

    it 'can remove a card from a tier' do
      expect(tournament_lists[0].tier_positions[0]["cards"]).to include("Lava Hound")

      put("/api/tier_lists/#{tournament_lists[0].id}", params: {
        "remove_card" => {
          "card_name" => "Lava Hound"
        }
      })

      body = JSON.parse(response.body)

      expect(tournament_lists[0].reload.tier_positions[0]["cards"]).not_to include("Lava Hound")
    end

    context 'when adding a card to a tier' do
      it 'can add it at the first position' do
        expect(tournament_lists[0].tier_positions[0]["cards"]).not_to include("Goblins")

        put("/api/tier_lists/#{tournament_lists[0].id}", params: {
          "update_card_position" => {
            "card_name" => "Goblins",
            "tier_index" => 0,
            "position" => 0
          }
        })

        body = JSON.parse(response.body)

        expect(tournament_lists[0].reload.tier_positions[0]["cards"]).to include("Goblins")
        expect(tournament_lists[0].reload.tier_positions[0]["cards"].first).to eq("Goblins")
      end

      it 'can add it at the last position' do
        expect(tournament_lists[0].tier_positions[0]["cards"]).not_to include("Goblins")

        put("/api/tier_lists/#{tournament_lists[0].id}", params: {
          "update_card_position" => {
            "card_name" => "Goblins",
            "tier_index" => 0,
            "position" => -1
          }
        })

        body = JSON.parse(response.body)

        expect(tournament_lists[0].reload.tier_positions[0]["cards"]).to include("Goblins")
        expect(tournament_lists[0].reload.tier_positions[0]["cards"].last).to eq("Goblins")
      end

      it 'can add it at the any position' do
        expect(tournament_lists[0].tier_positions[0]["cards"]).not_to include("Goblins")

        put("/api/tier_lists/#{tournament_lists[0].id}", params: {
          "update_card_position" => {
            "card_name" => "Goblins",
            "tier_index" => 0,
            "position" => 2
          }
        })

        body = JSON.parse(response.body)

        expect(tournament_lists[0].reload.tier_positions[0]["cards"]).to include("Goblins")
        expect(tournament_lists[0].reload.tier_positions[0]["cards"][2]).to eq("Goblins")
      end
    end

    context 'when moving a card within a tier' do
      it 'can move a card to the first position' do
        expect(tournament_lists[0].tier_positions[0]["cards"]).to include("Baby Dragon")
        expect(tournament_lists[0].tier_positions[0]["cards"].first).not_to eq("Baby Dragon")

        put("/api/tier_lists/#{tournament_lists[0].id}", params: {
          "update_card_position" => {
            "card_name" => "Baby Dragon",
            "tier_index" => 0,
            "position" => 0
          }
        })

        body = JSON.parse(response.body)

        expect(tournament_lists[0].reload.tier_positions[0]["cards"]).to include("Baby Dragon")
        expect(tournament_lists[0].reload.tier_positions[0]["cards"].first).to eq("Baby Dragon")
      end

      it 'can move a card to the last position' do
        expect(tournament_lists[0].tier_positions[0]["cards"]).to include("Lava Hound")
        expect(tournament_lists[0].tier_positions[0]["cards"].last).not_to eq("Lava Hound")

        put("/api/tier_lists/#{tournament_lists[0].id}", params: {
          "update_card_position" => {
            "card_name" => "Lava Hound",
            "tier_index" => 0,
            "position" => -1
          }
        })

        body = JSON.parse(response.body)

        expect(tournament_lists[0].reload.tier_positions[0]["cards"]).to include("Lava Hound")
        expect(tournament_lists[0].reload.tier_positions[0]["cards"].last).to eq("Lava Hound")
      end

      it 'can move a card to the any position' do
        expect(tournament_lists[0].tier_positions[0]["cards"]).to include("Lava Hound")
        expect(tournament_lists[0].tier_positions[0]["cards"][1]).not_to eq("Lava Hound")

        put("/api/tier_lists/#{tournament_lists[0].id}", params: {
          "update_card_position" => {
            "card_name" => "Lava Hound",
            "tier_index" => 0,
            "position" => 1
          }
        })

        body = JSON.parse(response.body)

        expect(tournament_lists[0].reload.tier_positions[0]["cards"]).to include("Lava Hound")
        expect(tournament_lists[0].reload.tier_positions[0]["cards"][1]).to eq("Lava Hound")
      end
    end

    it 'can a card between tiers' do
      expect(tournament_lists[0].tier_positions[0]["cards"]).to include("Lava Hound")
      expect(tournament_lists[0].tier_positions[1]["cards"]).not_to include("Lava Hound")

      put("/api/tier_lists/#{tournament_lists[0].id}", params: {
        "update_card_position" => {
          "card_name" => "Lava Hound",
          "tier_index" => 1,
          "position" => 1
        }
      })

      body = JSON.parse(response.body)

      expect(tournament_lists[0].reload.tier_positions[0]["cards"]).not_to include("Lava Hound")
      expect(tournament_lists[0].reload.tier_positions[1]["cards"]).to include("Lava Hound")
      expect(tournament_lists[0].reload.tier_positions[1]["cards"][1]).to eq("Lava Hound")
    end
  end

  describe 'DELETE /api/tier_lists/:id' do
    it 'can delete a tier list' do
      expect(TierList.all.count).to eq(4)
      expect(TierList.find_by(id: tournament_lists[0].id)).not_to eq(nil)

      delete("/api/tier_lists/#{tournament_lists[0].id}")

      body = JSON.parse(response.body)

      expect(TierList.all.count).to eq(3)
      expect(TierList.find_by(id: tournament_lists[0].id)).to eq(nil)
    end
  end
end
