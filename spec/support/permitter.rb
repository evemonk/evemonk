# frozen_string_literal: true

module Permitter
  def permitter(params)
    ActionController::Parameters.new(params).permit!
  end

  # alias :permit! :permit
end

RSpec.configure do |config|
  config.include Permitter, type: :controller
end
