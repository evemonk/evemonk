# frozen_string_literal: true

class CharacterEmploymentHistoryRowComponentPreview < ActionView::Component::Preview
  def corporation_exists
    eve_corporation = FactoryBot.build(:eve_corporation)

    render(CharacterEmploymentHistoryRowComponent.new(corporation: eve_corporation, start_date: Time.zone.now))
  end
end
