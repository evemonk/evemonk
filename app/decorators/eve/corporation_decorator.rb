# frozen_string_literal: true

module Eve
  class CorporationDecorator
    def tax_rate
      object.tax_rate.to_s
    end
  end
end
