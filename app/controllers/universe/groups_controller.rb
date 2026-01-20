# frozen_string_literal: true

module Universe
  class GroupsController < ApplicationController
    allow_unauthenticated_access

    def show
      # @group = Eve::Group.find_by(group_id: params[:id])
    end
  end
end
