# frozen_string_literal: true

module Admin
  module Eve
    class GroupsController < Admin::ApplicationController
      include DisableModifications
    end
  end
end
