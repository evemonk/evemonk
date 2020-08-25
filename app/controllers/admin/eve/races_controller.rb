# frozen_string_literal: true

module Admin
  module Eve
    class RacesController < Admin::ApplicationController
      include DisableModifications
    end
  end
end
