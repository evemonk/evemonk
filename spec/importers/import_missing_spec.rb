# frozen_string_literal: true

require "rails_helper"

describe ImportMissing do
  describe "#import" do
    specify { expect { subject.import }.not_to raise_error }
  end
end
