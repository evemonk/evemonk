# frozen_string_literal: true

require 'rails_helper'

module Eve
  describe AncestryDecorator do
    describe '#as_json' do
      let!(:ancestry) do
        build_stubbed(:eve_ancestry,
                      ancestry_id: 24,
                      name: 'Slave Child',
                      bloodline_id: 4,
                      description: 'Millions of slaves within the Amarr Empire dream of escape...',
                      short_description: 'Torn from the cold and brought to the warmth of a new life.',
                      icon_id: 1664)
      end

      subject { ancestry.decorate.as_json }

      its([:ancestry_id]) { should eq(24) }

      its([:name]) { should eq('Slave Child') }

      its([:bloodline_id]) { should eq(4) }

      its([:description]) { should eq('Millions of slaves within the Amarr Empire dream of escape...') }

      its([:short_description]) { should eq('Torn from the cold and brought to the warmth of a new life.') }

      its([:icon_id]) { should eq(1664) }
    end
  end
end
