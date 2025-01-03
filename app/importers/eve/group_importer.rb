# frozen_string_literal: true

module Eve
  class GroupImporter < BaseImporter
    attr_reader :group_id, :locale

    # @param group_id [Integer]
    # @param locale [Symbol] Default: :en
    def initialize(group_id, locale = :en)
      @group_id = group_id
      @locale = locale
    end

    def import
      import! do
        Mobility.with_locale(locale) do
          eve_group = Eve::Group.find_or_initialize_by(id: group_id)

          eve_group.update!(esi.as_json)
        rescue EveOnline::Exceptions::ResourceNotFound
          Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Group ID #{group_id}")

          eve_group.destroy!
        end
      end
    end

    private

    def esi
      @esi ||= EveOnline::ESI::UniverseGroup.new(group_id: group_id, language: LanguageMapper::LANGUAGES[locale])
    end
  end
end
