# frozen_string_literal: true

class CharacterAgentsRowComponent < ActionView::Component::Base
  attr_reader :standing, :index

  def initialize(standing:, index:)
    @standing = standing
    @index = index
  end
end
