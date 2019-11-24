# frozen_string_literal: true

module Api
  module Eve
    class CorporationsController < BaseController
      skip_before_action :authenticate

      def index
        @corporations = ::Eve::CorporationsSearcher
          .new(params[:q])
          .search
          .page(params[:page])
          .decorate
      end

      def show
        @corporation = ::Eve::Corporation
          .find_by!(corporation_id: params[:id])
          .decorate
      end
    end
  end
end
