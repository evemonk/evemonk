# frozen_string_literal: true

module Eve
  class StarDecorator < ApplicationDecorator
    # decorates_associations :system, :type
    decorates_associations :type
  end
end
