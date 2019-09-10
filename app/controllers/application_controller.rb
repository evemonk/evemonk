# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  after_action :verify_authorized, except: :index

  after_action :verify_policy_scoped, only: :index

  attr_reader :current_user
end
