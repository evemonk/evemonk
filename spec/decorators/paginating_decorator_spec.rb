# frozen_string_literal: true

require 'rails_helper'

describe PaginatingDecorator do
  subject { described_class.new(User.none) }

  it { should be_a(Draper::CollectionDecorator) }

  # TODO: write specs
end
