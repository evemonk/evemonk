# frozen_string_literal: true

class WelcomeController < ApplicationController
  skip_before_action :require_login

  def index
    @alliances = ::Eve::Alliance.order(characters_count: :desc).limit(20).decorate
    @corporations = ::Eve::Corporation.order(member_count: :desc).limit(20).decorate
  end
end
