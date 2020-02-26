# frozen_string_literal: true

class CharacterEmploymentHistoryRowComponentPreview < ActionView::Component::Preview
  def corporation_exists
    eve_corporation = FactoryBot.build(:eve_corporation).decorate

    render(CharacterEmploymentHistoryRowComponent.new(corporation: eve_corporation,
      start_date: Time.zone.now))
  end

  def corporation_not_exists
    render(CharacterEmploymentHistoryRowComponent.new(corporation: nil,
      start_date: Time.zone.now))
  end
end
