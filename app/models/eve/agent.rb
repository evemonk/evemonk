# frozen_string_literal: true

module Eve
  class Agent < ApplicationRecord
    include Locationable
    include Imageable

    belongs_to :corporation, optional: true

    # belongs_to :agent_type_id

    belongs_to :division, optional: true

    # Standing are private. Don't expose them via API.
    has_many :standings, as: :standingable # rubocop:disable Rails/HasManyOrHasOneDependent

    # TODO: location -> API

    def icon_tiny
      character_portrait_url(32)
    end

    def icon_small
      character_portrait_url(64)
    end

    def icon_medium
      character_portrait_url(128)
    end

    def icon_large
      character_portrait_url(256)
    end

    def icon_huge
      character_portrait_url(512)
    end

    def icon_gigantic
      character_portrait_url(1024)
    end

    private

    def character_portrait_url(size)
      imageable_url("characters", id, "portrait", size)
    end
  end
end
