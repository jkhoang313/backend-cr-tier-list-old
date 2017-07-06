clyde = User.create(user_name: "Clyde", email: "clyde@crapp.com")

TierList.create(
  user_id: clyde.id,
  title: "Clyde's Tournament Tier List",
  list_type: 1,
  description: "Comprehensive tier list for tournament capped cards. Based on tournament play and challenge play. Bi-weekly tier list!",
  upvotes: 0,
  tier_positions: [
    {
      name: "S-tier",
      description: "The best cards in the game",
      notes: "Bomber just reached S tier!",
      cards: ["Bomber", "Bowler", "Bomb Tower"]
    },
    {
      name: "A-tier",
      description: "The second best cards in the game",
      notes: "Barbarian Hut might move up soon",
      cards: ["Barbarian Hut", "Baby Dragon"]
    }
  ]
)

TierList.create(
  user_id: clyde.id,
  title: "Clyde's Ladder Tier List",
  list_type: 2,
  description: "Tier list for high trophy ladder play! (5000+)",
  upvotes: 0,
  tier_positions: [
    {
      name: "S-tier",
      description: "Good cards as long as you have the levels for it",
      notes: "Miner reigns supreme",
      cards: ["Lava Hound", "Miner", "The Log"]
    },
    {
      name: "A-tier",
      description: "Still good even if underleveled",
      notes: "Tank heavy meta",
      cards: ["Golem", "Giant"]
    }
  ]
)

bonnie = User.create(user_name: "Bonnie", email: "bonnie@crapp.com")
tc = User.create(user_name: "Trainer Chris", email: "tc@crapp.com")
cmchugh = User.create(user_name: "CMcHugh", email: "cmchugh@crapp.com")
woody = User.create(user_name: "Woody", email: "woody@crapp.com")
perseus = User.create(user_name: "Perseus", email: "perseus@crapp.com")
intel = User.create(user_name: "Intel", email: "intel@crapp.com")

TierList.create(
  user_id: bonnie.id,
  title: "Bonnie's Tournament Tier List",
  list_type: 1,
  description: "Comprehensive tier list for tournament capped cards. Based on tournament play and challenge play. Bi-weekly tier list!",
  upvotes: 0,
  tier_positions: [
    {
      name: "Awesome tier",
      description: "The best cards in the game",
      notes: "Bomber just reached S tier!",
      cards: ["Bomber", "Bowler", "Bomb Tower"]
    },
    {
      name: "Great tier",
      description: "The second best cards in the game",
      notes: "Barbarian Hut might move up soon",
      cards: ["Barbarian Hut", "Baby Dragon"]
    },
    {
      name: "Good tier",
      description: "The third best cards in the game",
      notes: "",
      cards: ["Barbarians", "Battle Ram"]
    },
    {
      name: "Okay tier",
      description: "The fourth best cards in the game",
      notes: "",
      cards: ["Elite Barbarians", "Lightning"]
    },
    {
      name: "Bad tier",
      description: "The worst cards in the game",
      notes: "",
      cards: ["Lumberjack", "Witch"]
    }
  ]
)

TierList.create(
  user_id: perseus.id,
  title: "Random tournament list",
  list_type: 1,
  description: "Tier list for high trophy ladder play! (5000+)",
  upvotes: 0,
  tier_positions: [
    {
      name: "S-tier",
      description: "Good cards as long as you have the levels for it",
      notes: "Miner reigns supreme",
      cards: ["Lava Hound", "Miner", "The Log"]
    },
    {
      name: "A-tier",
      description: "Still good even if underleveled",
      notes: "Tank heavy meta",
      cards: ["Golem", "Giant"]
    }
  ]
)

[bonnie, tc, cmchugh, woody, perseus, intel].each do |user|
  TierList.create(
    user_id: user.id,
    title: "2v2 list by #{user.user_name}",
    list_type: 3,
    description: "2v2 ladder/clan/challenge play",
    upvotes: 0,
    tier_positions: [
      {
        name: "S-tier",
        description: "Good cards as long as you have the levels for it",
        notes: "The best cards for duo play",
        cards: ["Tornado", "Executioner", "Rocket", "Inferno Tower"]
      },
      {
        name: "A-tier",
        description: "Still good even if underleveled",
        notes: "Tank heavy meta",
        cards: ["Lightning", "Bowler"]
      }
    ]
  )
end

([bonnie, tc, cmchugh, woody, perseus, intel] * 2).each.with_index(1) do |user, index|
  TierList.create(
    user_id: user.id,
    title: "Draft tier list ##{index}",
    list_type: 4,
    description: "Tier list for Draft play!",
    upvotes: 0,
    tier_positions: [
      {
        name: "S-tier",
        description: "Good cards as long as you have the levels for it",
        notes: "The best cards for duo play",
        cards: ["Tornado", "Executioner", "Rocket", "Inferno Tower"]
      },
      {
        name: "A-tier",
        description: "Still good even if underleveled",
        notes: "Tank heavy meta",
        cards: ["Lightning", "Bowler"]
      }
    ]
  )
end
