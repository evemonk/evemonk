# frozen_string_literal: true

class FaqsController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    skip_authorization
  end
end
