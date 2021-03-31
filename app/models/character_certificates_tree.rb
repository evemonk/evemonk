# frozen_string_literal: true

class CharacterCertificatesTree
  attr_reader :character

  def initialize(character)
    @character = character
  end

  def preload
    groups

    certificates

    self
  end

  def groups
    @groups ||= Eve::Group.published.where(group_id: group_ids).order(:name_en).to_a
  end

  def certificates_in_group(group_id)
    certificates.select { |certificate| certificate.group_id == group_id }.sort_by(&:name)
  end

  private

  def group_ids
    Eve::Certificate.pluck(:group_id).sort.uniq
  end

  def certificates
    @certificates ||= Eve::Certificate.all.to_a
  end
end
