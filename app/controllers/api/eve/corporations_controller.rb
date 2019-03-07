# frozen_string_literal: true

module Api
  module Eve
    class CorporationsController < BaseController
      skip_before_action :authenticate
    end
  end
end
