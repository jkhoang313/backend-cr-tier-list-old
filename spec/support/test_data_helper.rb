module TestDataHelper
  def create_user
    User.create(user_name: "Clyde", email: "clyde@crapp.com")
  end

  def create_tournament_lists
    [TierList.create(
      user_id: User.first.id,
      name: "Test Tournament Tier List",
      list_type: 1,
      description: "first tournament tier list",
      tier_positions: [
        {
          title: "test tier",
          cards: ["Lava Hound", "Baby Dragon", "Musketeer"]
        },
        {
          title: "test tier 2",
          cards: ["Three Musketeers", "Bandit"]
        }
      ]
    ),
    TierList.create(
      user_id: User.first.id,
      name: "Test Tournament Tier List 2",
      list_type: 1,
      description: "second tournament tier list"
    )]
  end

  def create_ladder_lists
    [TierList.create(
      user_id: User.first.id,
      name: "Test ladder Tier List",
      list_type: 2,
      description: "first ladder tier list",
      upvotes: 10
    ),
    TierList.create(
    user_id: User.first.id,
      name: "Test ladder Tier List 2",
      list_type: 2,
      description: "second ladder tier list",
      upvotes: 5
    )]
  end
end
