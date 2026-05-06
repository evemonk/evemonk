# frozen_string_literal: true

module Eve
  class Alliance < ApplicationRecord
    include Meilisearch::Rails
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

    meilisearch enqueue: :trigger_update_index_job do
      searchable_attributes [:name, :ticker]
    end

    has_one_attached :logo

    class << self
      # @param record [Eve::Alliance] The Eve::Alliance record that was updated or deleted
      # @param remove [Boolean] Whether the record was deleted (true) or updated (false)
      def trigger_update_index_job(record, remove)
        Meilisearch::Eve::ReindexAllianceJob.perform_later(record.id, remove)
      end
    end

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
