# frozen_string_literal: true

module Admin
  module Eve
    class MarketGroupsController < Admin::ApplicationController
      include DisableModifications
    end
  end
end
