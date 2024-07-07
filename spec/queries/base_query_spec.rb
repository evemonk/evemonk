# frozen_string_literal: true

require "rails_helper"

RSpec.describe BaseQuery do
  describe "#scope" do
    specify { expect { subject.scope }.to raise_error(NotImplementedError) }
  end

  describe "#query" do
    specify { expect { subject.query }.to raise_error(NotImplementedError) }
  end
end
