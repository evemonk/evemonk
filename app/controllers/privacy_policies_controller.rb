# frozen_string_literal: true

class PrivacyPoliciesController < ApplicationController
  allow_unauthenticated_access

  def show
    skip_authorization
  end
end
