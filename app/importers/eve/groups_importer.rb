# frozen_string_literal: true

module Eve
  class GroupsImporter < BaseImporter
    attr_reader :page

    def initialize(page = 1)
      @page = page
    end

    def import
      import! do
        import_groups

        import_other_pages
      end
    end

    def esi
      @esi ||= EveOnline::ESI::UniverseGroups.new(page: page)
    end

    private

    def import_groups
      esi.group_ids.each do |group_id|
        unless Eve::Group.exists?(id: group_id)
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
