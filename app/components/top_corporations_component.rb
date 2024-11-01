# frozen_string_literal: true

class TopCorporationsComponent < ApplicationComponent
  include Turbo::FramesHelper

  # @param corporations [ActiveRecord::Relation<Eve::Corporation>, Array<Eve::Corporation>]
  # @param lazy [Boolean]
  def initialize(corporations:, lazy:)
    @corporations = corporations
    @lazy = lazy
  end
end
