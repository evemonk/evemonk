# frozen_string_literal: true

# TODO: update
module Eve
  class LocalGroupsImporter
    def import
      Eve::Group.pluck(:group_id).each do |group_id|
        Eve::UpdateGroupJob.perform_later(group_id)
      end
    end
  end
end
