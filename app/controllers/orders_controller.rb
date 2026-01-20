# frozen_string_literal: true

class OrdersController < ApplicationController
  def index
    @character = policy_scope(Character)
      .includes(:alliance, :corporation)
      .find_by!(character_id: params[:character_id])

    @sell_orders = @character.character_orders
      .where(is_buy_order: [nil, false], is_corporation: false)
      .includes(:type)
      .page(params[:page])
  end
end
