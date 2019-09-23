# frozen_string_literal: true

class WelcomeController < ApplicationController
  skip_before_action :require_login

  def index
    @alliances = policy_scope(::Eve::Alliance).order(characters_count: :desc).limit(20).decorate
    @corporations = policy_scope(::Eve::Corporation).order(member_count: :desc).limit(20).decorate
  end
end
