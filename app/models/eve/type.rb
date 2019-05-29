# frozen_string_literal: true

module Eve
  class Type < ApplicationRecord
    has_many :type_dogma_attributes, primary_key: :type_id, foreign_key: :type_id, dependent: :destroy
  end
end
