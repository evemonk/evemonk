# frozen_string_literal: true

module Api
  module Eve
    class BlueprintsController < BaseController
      def index
        @blueprints = ::Eve::BlueprintsSearcher.new(params[:q])
          .search
          .page(params[:page])
      end
    end
  end
end
