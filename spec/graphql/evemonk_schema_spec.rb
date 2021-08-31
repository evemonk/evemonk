# frozen_string_literal: true

require "rails_helper"

describe EvemonkSchema do
  it { expect(described_class.default_max_page_size).to eq(50) }

  specify { expect { described_class.resolve_type("", "", "") }.to raise_error(GraphQL::RequiredImplementationMissingError) }

  specify { expect { described_class.id_from_object("", "", "") }.not_to raise_error }

  specify { expect { described_class.object_from_id("", "") }.not_to raise_error }
end
