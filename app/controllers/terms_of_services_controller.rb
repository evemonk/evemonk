# frozen_string_literal: true

class TermsOfServicesController < ApplicationController
  skip_before_action :authenticate_user!

  def show
  end
end
