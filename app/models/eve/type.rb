# frozen_string_literal: true

module Eve
  class Type < ApplicationRecord
    self.primary_key = "type_id"

    include PgSearch::Model
    include ActionView::Helpers::NumberHelper
    include Imageable

    extend Mobility

    PRIMARY_ATTRIBUTE_NAME = "primaryAttribute"
    SECONDARY_ATTRIBUTE_NAME = "secondaryAttribute"

    has_paper_trail

    translates :name, :description

    belongs_to :graphic, optional: true

    belongs_to :group, optional: true

    belongs_to :icon, optional: true

    belongs_to :market_group, optional: true

    has_many :type_dogma_attributes,
      foreign_key: "type_id",
      dependent: :destroy

    has_many :dogma_attributes, through: :type_dogma_attributes

    # TODO: import
    has_many :type_dogma_effects,
      primary_key: "type_id",
      foreign_key: "type_id",
      dependent: :destroy

    # TODO: import
    # has_many :dogma_effects,
    #   through: :type_dogma_effects

    scope :published, -> { where(published: true) }

    scope :blueprints, -> { where(is_blueprint: true) }

    scope :manufacturing_items, -> { where(is_manufacturing_item: true) }

    pg_search_scope :search_by_name,
      against: :name_en,
      using: {
        tsearch: {
          prefix: true,
          negation: true
        }
      }

    def implant_bonuses
      @implant_bonuses ||= ImplantBonuses.new(self).implant_bonuses
    end

    def primary_attribute
      @primary_attribute ||= begin
        value = type_dogma_attributes.find { |tda| tda.dogma_attribute.name == PRIMARY_ATTRIBUTE_NAME }.value
        Eve::DogmaAttribute.find_by!(attribute_id: Integer(value))
      end
    end

    def secondary_attribute
      @secondary_attribute ||= begin
        value = type_dogma_attributes.find { |tda| tda.dogma_attribute.name == SECONDARY_ATTRIBUTE_NAME }.value
        Eve::DogmaAttribute.find_by!(attribute_id: Integer(value))
      end
    end

    def icon_tiny
      type_icon_url(32)
    end

    def icon_small
      type_icon_url(64)
    end

    def render_tiny
      type_render_url(32)
    end

    def render_small
      type_render_url(64)
    end

    def render_medium
      type_render_url(128)
    end

    def render_large
      type_render_url(256)
    end

    def render_huge
      type_render_url(512)
    end

    def relic_tiny
      type_relic_url(32)
    end

    def relic_small
      type_relic_url(64)
    end

    def average_price_formatted
      number_with_delimiter(average_price.to_i, delimiter: " ")
    end

    # def simple_description
    #   # simple_format(SafeEveSanitizer.new.sanitize(description))
    #   SafeEveSanitizer.new.sanitize(description)
    # end

    private

    def type_icon_url(size)
      imageable_url("types", type_id, "icon", size)
    end

    def type_render_url(size)
      imageable_url("types", type_id, "render", size)
    end

    def type_relic_url(size)
      imageable_url("types", type_id, "relic", size)
    end
  end
end
