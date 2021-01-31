# frozen_string_literal: true

module Api
  module Eve
    class TypesController < BaseController
      def index
        @types = ::Eve::Type
          .where(published: true)
          .includes(:type_dogma_attributes, :type_dogma_effects)
      end

      def show
        @type = ::Eve::Type
          .where(published: true)
          .includes(:type_dogma_attributes, :type_dogma_effects)
          .find_by!(type_id: params[:id])
      end
    end
  end
end
