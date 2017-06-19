class TierListsController < ApplicationController
  def index
    list_type = params["list_type"]

    tier_lists = TierList.where(list_type: list_type).order(upvotes: :DESC)

    render json: { tier_lists: tier_lists.map {|tier_list| tier_list} }
  end

  def show
    tier_list = TierList.find(params["id"])

    render json: tier_list
  end

  def create
    new_tier_list = TierList.create(tier_list_params)

    render json: new_tier_list
  end

  def update
    tier_list = TierList.find(params["id"])
    tier_list.update(tier_list_params)

    if params.include? "update_upvotes"
      tier_list.change_upvotes(params["update_upvotes"].to_i)
    end

    render json: tier_list
  end

  def destroy
    tier_list = TierList.find(params["id"])
    tier_list.destroy

    render json: {}
  end

  private
  def tier_list_params
    params.permit(:name, :list_type, :description)
  end
end
