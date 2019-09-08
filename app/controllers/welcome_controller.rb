# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @alliances = Eve::Alliance.limit(20).decorate
    @corporations = Eve::Corporation.limit(20).decorate
  end
end
