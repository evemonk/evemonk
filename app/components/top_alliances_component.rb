# frozen_string_literal: true

class TopAlliancesComponent < ApplicationComponent
  include Turbo::FramesHelper

  # @param alliances [ActiveRecord::Relation<Eve::Alliance>, Array<Eve::Alliance>]
  # @param lazy [Boolean]
  def initialize(alliances:, lazy:)
    @alliances = alliances
    @lazy = lazy
  end
end
