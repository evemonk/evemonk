# frozen_string_literal: true

module Admin
  module Eve
    class CorporationsController < Admin::ApplicationController
      include DisableModifications
    end
  end
end
