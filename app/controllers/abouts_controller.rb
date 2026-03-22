# frozen_string_literal: true

class AboutsController < ApplicationController
  def show
    skip_authorization
  end
end
