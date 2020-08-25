# frozen_string_literal: true

module Admin
  module Eve
    class StationsController < Admin::ApplicationController
      include DisableModifications
    end
  end
end
