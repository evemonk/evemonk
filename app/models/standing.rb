# frozen_string_literal: true

class Standing < ApplicationRecord
  has_paper_trail

  belongs_to :character
end
