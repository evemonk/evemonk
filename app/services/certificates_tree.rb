# frozen_string_literal: true

class CertificatesTree
  attr_reader :character

  def initialize(character)
    @character = character
  end

  def group_ids
    Eve::Certificate.pluck(:group_id).sort.uniq
  end

  def groups
    @groups ||= Eve::Group.published
      .where(group_id: group_ids)
      .order(:name_en)
  end
end
