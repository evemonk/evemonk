# frozen_string_literal: true

module Universe
  class MarketGroupItemsController < ApplicationController
    skip_before_action :authenticate_user!

    def index
      @market_group = Eve::MarketGroup.find_by!(market_group_id: params[:market_group_id])
      @types = @market_group.types.order(:name_en)
    end
  end
end
