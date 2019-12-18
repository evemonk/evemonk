# frozen_string_literal: true

module Eve
  class GroupsImporter
    attr_reader :page, :esi

    def initialize(page = 1)
      @page = page
      @esi = EveOnline::ESI::UniverseGroups.new(page: @page)
    end

    def import
      ActiveRecord::Base.transaction do
        etag = Eve::Etag.find_or_initialize_by(url: esi.url)

        esi.etag = etag.etag

        return if esi.not_modified?

        import_groups

        import_other_pages

        etag.update!(etag: esi.etag, body: esi.response)
      end
    end

    private

    def import_groups
      esi.group_ids.each do |group_id|
        unless Eve::Group.exists?(group_id: group_id)
          Eve::UpdateGroupJob.perform_later(group_id)
        end
      end
    end

    def import_other_pages
      return if page != 1 || esi.total_pages == 1

      (2..esi.total_pages).each do |next_page|
        Eve::UpdateGroupsJob.perform_later(next_page)
      end
    end
  end
end
