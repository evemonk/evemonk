# frozen_string_literal: true

module Eve
  class LocalGroupsImporter
    def import
      Eve::Group.ids.each do |id|
        Eve::UpdateGroupJob.perform_later(id)
      end
    end
  end
end
