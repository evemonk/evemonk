# frozen_string_literal: true

module Universe
  class GroupsController < ApplicationController
    skip_before_action :authenticate_user!

    def show
      # @group = Eve::Group.find_by(group_id: params[:id])
    end
  end
end
