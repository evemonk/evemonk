# frozen_string_literal: true

class FaqsController < ApplicationController
  skip_before_action :require_login
end
