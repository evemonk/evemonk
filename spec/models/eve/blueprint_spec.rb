# frozen_string_literal: true

require "rails_helper"

describe Eve::Blueprint do
  it { should be_a(Eve::Type) }

  it { should have_many(:blueprint_invention_materials).with_primary_key("type_id").dependent(:destroy) }

  it { should have_many(:blueprint_invention_products).with_primary_key("type_id").dependent(:destroy) }

  it { should have_many(:blueprint_invention_skills).with_primary_key("type_id").dependent(:destroy) }

  it { should have_many(:blueprint_manufacturing_materials).with_primary_key("type_id").dependent(:destroy) }

  it { should have_many(:blueprint_manufacturing_products).with_primary_key("type_id").dependent(:destroy) }

  it { should have_many(:blueprint_manufacturing_skills).with_primary_key("type_id").dependent(:destroy) }
end
