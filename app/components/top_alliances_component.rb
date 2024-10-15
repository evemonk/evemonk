# frozen_string_literal: true

class TopAlliancesComponent < ApplicationComponent
  include Turbo::FramesHelper

  # @param alliances [ActiveRecord::Relation<Eve::Alliance>, Array<Eve::Alliance>]
  def initialize(alliances = Eve::Alliance.none)
    @alliances = alliances
  end
end
