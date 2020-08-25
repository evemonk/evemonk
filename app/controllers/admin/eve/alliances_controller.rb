# frozen_string_literal: true

module Admin
  module Eve
    class AlliancesController < Admin::ApplicationController
      include ::Admin::DisableModifications
    end
  end
end
