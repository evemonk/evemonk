# frozen_string_literal: true

module Eve
  class Alliance < ApplicationRecord
    include PgSearch::Model
    include ActionView::Helpers::NumberHelper
    include Imageable

    belongs_to :creator_corporation,
      class_name: "Eve::Corporation",
      optional: true

    belongs_to :creator,
      class_name: "Eve::Character",
      optional: true

    belongs_to :executor_corporation,
      class_name: "Eve::Corporation",
      optional: true

    belongs_to :faction, optional: true

    has_many :corporations # rubocop:disable Rails/HasManyOrHasOneDependent

    has_many :characters, through: :corporations

    has_many :corporation_alliance_histories # rubocop:disable Rails/HasManyOrHasOneDependent

    after_create_commit :reset_corporations_count

    after_create_commit :reset_characters_count

    pg_search_scope :search_by_name_and_ticker, against: [:name, :ticker]

    has_one_attached :logo

    def reset_corporations_count
      update!(corporations_count: corporations.count)
    end

    def reset_characters_count
      update!(characters_count: corporations.sum(:member_count))
    end

    def icon_tiny
      alliance_logo_url(32)
    end

    def icon_small
      alliance_logo_url(64)
    end

    def icon_medium
      alliance_logo_url(128)
    end

    def icon_large
      alliance_logo_url(256)
    end

    def icon_huge
      alliance_logo_url(512)
    end

    def formatted_corporations_count
      number_with_delimiter(corporations_count, delimiter: " ")
    end

    def formatted_characters_count
      number_with_delimiter(characters_count, delimiter: " ")
    end

    private

    def alliance_logo_url(size)
      imageable_url("alliances", id, "logo", size)
    end
  end
end
