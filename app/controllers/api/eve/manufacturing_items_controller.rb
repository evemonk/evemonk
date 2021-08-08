# frozen_string_literal: true

module Api
  module Eve
    class ManufacturingItemsController < BaseController
      def index
        @items = ::Eve::SearchManufacturingItemsQuery.new(params[:q])
          .query
          .page(params[:page])
      end
    end
  end
end
