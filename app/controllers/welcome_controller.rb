# frozen_string_literal: true

class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    action = WelcomeIndexAction.new.perform
    @alliances = action.alliances
    @corporations = action.corporations
  end
end
