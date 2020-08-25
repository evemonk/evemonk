# frozen_string_literal: true

module Admin
  module Eve
    class FactionsController < Admin::ApplicationController
      include DisableModifications
    end
  end
end
