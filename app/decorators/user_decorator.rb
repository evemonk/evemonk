# frozen_string_literal: true

class UserDecorator < ApplicationDecorator
  decorates_associations :sessions, :characters
end
