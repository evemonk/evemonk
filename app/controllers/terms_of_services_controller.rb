# frozen_string_literal: true

class TermsOfServicesController < ApplicationController
  def show
    skip_authorization
  end
end
