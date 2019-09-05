# frozen_string_literal: true

module Universe
  class CharactersController < ApplicationController
    include Pundit

    after_action :verify_authorized, except: :index

    after_action :verify_policy_scoped, only: :index

    attr_reader :current_user

    def index
      @characters = ::Eve::CharactersSearcher
        .new(params[:q], policy_scope(::Eve::Character))
        .search
        .page(params[:page])
        .decorate
    end

    def show
      @character = policy_scope(::Eve::Character)
        .find_by!(character_id: params[:id])
        .decorate

      skip_authorization
    end
  end
end
