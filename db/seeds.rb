# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

clyde = User.create(user_name: "Clyde", email: "clyde@crapp.com")

TierList.create(
  user_id: clyde.id,
  name: "Clyde's Tournament Tier List",
  list_type: 1,
  description: "Comprehensive tier list for tournament capped cards. Based on tournament play and challenge play. Bi-weekly tier list!",
  upvotes: 0,
  tier_positions: [
    {
      id: 1,
      title: "S-tier",
      description: "The best cards in the game",
      notes: "Bomber just reached S tier!",
      cards: ["Bomber", "Bowler", "Bomb Tower"]
    },
    {
      id: 23,
      title: "A-tier",
      description: "The second best cards in the game",
      notes: "Barbarian Hut might move up soon",
      cards: ["Barbarian Hut", "Baby Dragon"]
    }
  ]
)
