# frozen_string_literal: true

module Api
  module Eve
    class BlueprintsController < BaseController
      skip_before_action :authenticate

      # Eve::Type.search("drake navi", fields: [:name_en], match: :word_start).map(&:name_en)

      def index
        @blueprints = ::Eve::BlueprintsSearcher.new(params[:q]).search.page(params[:page]).decorate
      end

      # def show
      #   @type = ::Eve::Type
      #               .where(published: true)
      #               .includes(:type_dogma_attributes, :type_dogma_effects)
      #               .find_by!(type_id: params[:id])
      #               .decorate
      # end
    end
  end
end
