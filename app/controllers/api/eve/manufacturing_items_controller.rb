# frozen_string_literal: true

module Api
  module Eve
    class ManufacturingItemsController < BaseController
      def index
        @items = ::Eve::ManufacturingItemsSearcher.new(params[:q])
          .search
          .page(params[:page])
          .decorate
      end
    end
  end
end
