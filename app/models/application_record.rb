# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  include ImageProxy

  self.abstract_class = true
end
