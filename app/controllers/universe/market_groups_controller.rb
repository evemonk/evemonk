# frozen_string_literal: true

module Universe
  class MarketGroupsController < ApplicationController
    allow_unauthenticated_access

    def index
      @market_groups = Eve::MarketGroup.main_groups
        .includes(:icon)
        .order(:name_en)
    end

    def show
      @market_group = Eve::MarketGroup.find_by!(market_group_id: params[:id])
      @market_groups = @market_group.subgroups.includes(:icon).order(:name_en)
    end
  end
end
