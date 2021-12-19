# frozen_string_literal: true

require "rails_helper"

describe ApplicationHelper do
  subject do
    class TestClass
      include ApplicationHelper
    end.new
  end

  it { expect(subject.respond_to?(:pagy_nav)).to eq(true) }
end
