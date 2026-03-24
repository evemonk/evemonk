# frozen_string_literal: true

class PrivacyPoliciesController < ApplicationController
  def show
    skip_authorization
  end
end
