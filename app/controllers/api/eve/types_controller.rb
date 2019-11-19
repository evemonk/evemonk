# frozen_string_literal: true

module Api
  module Eve
    class TypesController < BaseController
      skip_before_action :authenticate

      def index
        @types = ::Eve::Type
          .where(published: true)
          .includes(:type_dogma_attributes, :type_dogma_effects)
          .decorate
      end

      def show
        @type = ::Eve::Type
          .where(published: true)
          .includes(:type_dogma_attributes, :type_dogma_effects)
          .find_by!(type_id: params[:id])
          .decorate
      end
    end
  end
end
