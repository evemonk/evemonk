# frozen_string_literal: true

module Eve
  class AllianceDecorator
    def date_founded
      object.date_founded.iso8601
    end
  end
end
