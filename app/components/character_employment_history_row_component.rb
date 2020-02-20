class CharacterEmploymentHistoryRowComponent < ActionView::Component::Base
  attr_reader :corporation, :start_date

  def initialize(corporation:, start_date:)
    @corporation = corporation
    @start_date = start_date
  end
end
