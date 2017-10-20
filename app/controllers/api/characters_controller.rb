module Api
  class CharactersController < BaseController
    private

    def resource
      @character ||= Character.find(params[:id])
    end

    def collection
      @characters ||= policy_scope(Character).order(created_at: :asc)
                                             .page(params[:page])
    end
  end
end
