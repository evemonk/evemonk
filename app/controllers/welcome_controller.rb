# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @alliances = policy_scope(::Eve::Alliance).limit(20).decorate
    @corporations = policy_scope(::Eve::Corporation).limit(20).decorate
  end
end
