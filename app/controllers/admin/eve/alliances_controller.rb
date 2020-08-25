# frozen_string_literal: true

module Admin
  module Eve
    class AlliancesController < Admin::ApplicationController
      include DisableModifications
    end
  end
end
