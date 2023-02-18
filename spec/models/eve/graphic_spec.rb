# frozen_string_literal: true

require "rails_helper"

describe Eve::Graphic do
  it { should be_an(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { expect(described_class.table_name).to eq("eve_graphics") }
end
