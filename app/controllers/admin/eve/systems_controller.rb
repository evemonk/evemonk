# frozen_string_literal: true

module Admin
  module Eve
    class SystemsController < Admin::ApplicationController
      include DisableModifications
    end
  end
end
