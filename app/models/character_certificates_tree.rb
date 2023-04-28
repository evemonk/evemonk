# frozen_string_literal: true

class CharacterCertificatesTree
  # LEVELS = { 0 => "79_64_1.png",
  #            1 => "79_64_2.png",
  #            2 => "79_64_3.png",
  #            3 => "79_64_4.png",
  #            4 => "79_64_5.png",
  #            5 => "79_64_6.png"}

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
    @groups ||= Eve::Group.published.where(id: group_ids).order(:name_en).to_a
  end

  def certificates_in_group(group_id)
    certificates.select { |certificate| certificate.group_id == group_id }.sort_by(&:name)
  end

  # def certificate_level(certificate_id)
  #   (5..1).each do |level|
  #     certificate = certificates.find { |certificate| certificate.certificate_id == certificate_id }
  #
  #     certificate.certificate_skills
  #   end
  #
  #   0
  # end

  private

  def group_ids
    Eve::Certificate.pluck(:group_id).sort.uniq
  end

  def certificates
    # @certificates ||= Eve::Certificate.includes(:certificate_skills).all.to_a
    @certificates ||= Eve::Certificate.all.to_a
  end

  # def character_skills
  #   @character_skills ||= character.character_skills.to_a
  # end
end
