# frozen_string_literal: true

module Api
  module Eve
    class AlliancesSearchController < BaseController
      skip_before_action :authenticate

      def index
      end
    end
  end
end
