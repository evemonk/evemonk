# frozen_string_literal: true

module Eve
  class Alliance < ApplicationRecord
    has_many :characters, dependent: :destroy
  end
end
