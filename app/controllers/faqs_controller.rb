# frozen_string_literal: true

class FaqsController < ApplicationController
  def show
    skip_authorization
  end
end
