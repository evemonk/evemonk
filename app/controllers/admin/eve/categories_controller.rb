# frozen_string_literal: true

module Admin
  module Eve
    class CategoriesController < Admin::ApplicationController
      include DisableModifications
    end
  end
end
