# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @alliances = policy_scope(Eve::Alliance).none
    @corporations = policy_scope(Eve::Corporation).none
  end
end
