# frozen_string_literal: true

module Universe
  class CategoriesController < ApplicationController
    skip_before_action :authenticate_user!

    def index
      # @categories = Eve::Category.page(params[:page]).decorate
    end

    def show
      # @category = Eve::Category.find_by(category_id: params[:id]).decorate
    end
  end
end
