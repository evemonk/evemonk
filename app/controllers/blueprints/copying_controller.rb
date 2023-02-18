# frozen_string_literal: true

module Blueprints
  class CopyingController < ApplicationController
    skip_before_action :authenticate_user!

    def show
      @blueprint = Eve::Blueprint.blueprints.published.find(params[:id])

      @science = Eve::Skills.science

      # @science_copy_speed_bonus_per_level = @science.type_dogma_attributes
      #   .where(attribute_id: Eve::DogmaAttributes.copy_speed_bonus
      #     .attribute_id)
      #   .first
      #   .value

      @advanced_industry = Eve::Skills.advanced_industry

      # @advanced_industry_skill_industry_job_time_bonus_per_level = @advanced_industry.type_dogma_attributes
      #   .where(attribute_id: Eve::DogmaAttributes.advanced_industry_skill_industry_job_time_bonus
      #     .attribute_id)
      #   .first
      #   .value
      #
      # @implants = Eve::Type.joins(type_dogma_attributes: :dogma_attribute)
      #   .where(dogma_attribute: {name: Eve::DogmaAttributes::COPY_SPEED_BONUS})
      #   .where(group_id: Eve::Groups::CYBER_SCIENCE_ID)
      #   .order(:name_en)

      @implants = []
    end
  end
end
