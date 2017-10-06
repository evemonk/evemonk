module Api
  class CharactersController < BaseController
    private

    def resource
      @character ||= current_user.characters.find(params[:id])
    end

    def collection
      @characters ||= current_user.characters
                                  .order(created_at: :asc)
                                  .page(params[:page])
    end
  end
end
