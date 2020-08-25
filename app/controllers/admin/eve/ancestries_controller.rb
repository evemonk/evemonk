# frozen_string_literal: true

module Admin
  module Eve
    class AncestriesController < Admin::ApplicationController
      include DisableModifications
    end
  end
end
