# frozen_string_literal: true

module Universe
  class CategoriesController < ApplicationController
    skip_before_action :authenticate_user!

    def index
      @categories = policy_scope(Eve::Category).order(:name_en).page(params[:page])
    end

    def show
      # @category = Eve::Category.find_by(category_id: params[:id])
    end
  end
end
