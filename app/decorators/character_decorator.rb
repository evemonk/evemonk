# frozen_string_literal: true

class CharacterDecorator < Draper::Decorator
  delegate_all

  decorates_association :race

  decorates_association :bloodline

  decorates_association :faction

  decorates_association :ancestry

  decorates_association :alliance

  decorates_association :corporation

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def as_json(*)
    {
      id: id,
      uid: uid,
      name: name,
      description: description,
      # TODO: later
      # corporation_id: corporation_id,
      # birthday: birthday,
      gender: gender,
      race: race,
      bloodline: bloodline,
      faction: faction,
      ancestry: ancestry,
      alliance: alliance,
      corporation: corporation,
      security_status: security_status,
      # portrait: {
      #   small: portrait_small,
      #   medium: portrait_medium,
      #   large: portrait_large,
      #   huge: portrait_huge
      # },
      wallet: wallet,
      charisma: charisma,
      intelligence: intelligence,
      memory: memory,
      perception: perception,
      willpower: willpower,
      bonus_remaps: bonus_remaps,
      # last_remap_date: last_remap_date.iso8601,
      # accrued_remap_cooldown_date: accrued_remap_cooldown_date.iso8601,
      created_at: created_at.iso8601,
      updated_at: updated_at.iso8601
    }
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
end
