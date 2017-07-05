class TierListsController < ApplicationController
  def index
    list_type = params["list_type"]

    tier_lists = TierList.where(list_type: list_type.to_i).order(upvotes: :DESC)

    render json: { tier_lists: tier_lists.map {|tier_list| TierListSerializer.new(tier_list)} }, root: false
  end

  def show
    tier_list = TierList.find(params["id"])

    render json: tier_list
  end

  def create
    new_tier_list = TierList.create(tier_list_creation_params)

    render json: new_tier_list
  end

  def update
    tier_list = TierList.find(params["id"])

    if params.include? "update_upvotes"
      tier_list.change_upvotes(params["update_upvotes"].to_i)
    end

    if params.include? "update_tier_details"
      tier_list.update(tier_list_update_params)

      tier_list.update_tier_details(params["update_tier_details"])
    end

    if params.include? "update_card_position"
      card_name = params["update_card_position"]["card_name"]
      new_tier = params["update_card_position"]["tier_index"].to_i
      new_position = params["update_card_position"]["position"].to_i

      tier_list.update_card_position(card_name, new_tier, new_position)
    end

    if params.include? "remove_card"
      card_name = params["remove_card"]["card_name"]

      tier_list.remove_card_from_tiers(card_name)
    end

    render json: tier_list
  end

  def destroy
    tier_list = TierList.find(params["id"])
    tier_list.destroy

    render json: {}
  end

  private
  def tier_list_creation_params
    params.permit(:user_id, :title, :list_type, :description)
  end

  def tier_list_update_params
    params.require(:update_tier_details).permit(:user_id, :title, :list_type, :description)
  end
end
