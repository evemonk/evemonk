# frozen_string_literal: true

require 'rails_helper'

module Eve
  describe BloodlineDecorator do
    let(:bloodline) { build_stubbed(:eve_bloodline) }

    subject { described_class.new(bloodline) }

    it { should be_a(ApplicationDecorator) }

    describe '#as_json' do
      let(:bloodline) do
        build_stubbed(:eve_bloodline,
                      bloodline_id: 4,
                      name: 'Brutor',
                      description: 'A martial, strong-willed people, the Brutor...',
                      race_id: 2,
                      ship_type_id: 588,
                      corporation_id: 1_000_049,
                      perception: 9,
                      willpower: 7,
                      charisma: 6,
                      memory: 4,
                      intelligence: 4)
      end

      subject { bloodline.decorate.as_json }

      its([:bloodline_id]) { should eq(4) }

      its([:name]) { should eq('Brutor') }

      its([:description]) { should eq('A martial, strong-willed people, the Brutor...') }

      its([:race_id]) { should eq(2) }

      its([:ship_type_id]) { should eq(588) }

      its([:corporation_id]) { should eq(1_000_049) }

      its([:perception]) { should eq(9) }

      its([:willpower]) { should eq(7) }

      its([:charisma]) { should eq(6) }

      its([:memory]) { should eq(4) }

      its([:intelligence]) { should eq(4) }
    end
  end
end
