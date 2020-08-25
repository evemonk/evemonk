# frozen_string_literal: true

module Admin
  module Eve
    class ConstellationsController < Admin::ApplicationController
      include DisableModifications
    end
  end
end
