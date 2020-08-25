# frozen_string_literal: true

module Admin
  module Eve
    class BloodlinesController < Admin::ApplicationController
      include DisableModifications
    end
  end
end
