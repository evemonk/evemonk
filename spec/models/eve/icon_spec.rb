# frozen_string_literal: true

require "rails_helper"

describe Eve::Icon do
  it { should be_an(ApplicationRecord) }

  it { expect(described_class.table_name).to eq("eve_icons") }

  it { should respond_to(:versions) }
end
