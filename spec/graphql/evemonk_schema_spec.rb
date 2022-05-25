# frozen_string_literal: true

require "rails_helper"

describe EvemonkSchema do
  it { expect(described_class.default_max_page_size).to eq(50) }

  describe ".resolve_type" do
    specify { expect { described_class.resolve_type("", "", "") }.to raise_error(GraphQL::RequiredImplementationMissingError) }
  end

  describe ".id_from_object" do
    let(:object) { double }

    before { expect(object).to receive(:to_gid_param) }

    specify { expect { described_class.id_from_object(object, "", "") }.not_to raise_error }
  end

  describe ".object_from_id" do
    let(:global_id) { double }

    before { expect(GlobalID).to receive(:find).with(global_id) }

    specify { expect { described_class.object_from_id(global_id, "") }.not_to raise_error }
  end
end
