# frozen_string_literal: true

class OrdersController < ApplicationController
  def index
    @character = current_user.characters
      .includes(:alliance, :corporation)
      .find_by!(character_id: params[:character_id])
      .decorate

    @sell_orders = @character.character_orders
      .where(is_buy_order: [nil, false], is_corporation: false)
      .includes(:type)
      .page(params[:page])
      .decorate
  end
end
