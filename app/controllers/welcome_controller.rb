# frozen_string_literal: true

class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @alliances = ::Eve::Alliance.order(characters_count: :desc).limit(20).load_async
    @corporations = ::Eve::Corporation.not_npc.order(member_count: :desc).limit(20).load_async
  end
end
