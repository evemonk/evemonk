# frozen_string_literal: true

module Eve
  class SystemDecorator
    def security_status
      object.security_status.round(1)
    end
  end
end
