# frozen_string_literal: true

module Api
  module Eve
    class BlueprintsController < BaseController
      def index
        @blueprints = ::Eve::SearchBlueprintsQuery.new(params[:q])
          .query
          .page(params[:page])
      end
    end
  end
end
