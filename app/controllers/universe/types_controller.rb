# frozen_string_literal: true

module Universe
  class TypesController < ApplicationController
    skip_before_action :authenticate_user!

    def index
    end

    def show
      @type = Eve::Type.find_by!(type_id: params[:id]).decorate
    end
  end
end
