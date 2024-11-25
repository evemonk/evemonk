# frozen_string_literal: true

class ProfilesController < ApplicationController
  def show
    skip_authorization
  end
end
