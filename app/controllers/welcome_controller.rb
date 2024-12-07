# frozen_string_literal: true

class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @alliances = policy_scope(Eve::Alliance).none
    @corporations = policy_scope(Eve::Corporation).none
  end
end
