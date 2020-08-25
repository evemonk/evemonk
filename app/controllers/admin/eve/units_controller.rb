# frozen_string_literal: true

module Admin
  module Eve
    class UnitsController < Admin::ApplicationController
      include DisableModifications
    end
  end
end
