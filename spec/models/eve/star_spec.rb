# frozen_string_literal: true

require "rails_helper"

describe Eve::Star do
  it { should be_a(ApplicationRecord) }

  it { should respond_to(:versions) }

  it { expect(described_class.table_name).to eq("eve_stars") }
end
