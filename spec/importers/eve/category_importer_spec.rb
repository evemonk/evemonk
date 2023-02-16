# frozen_string_literal: true

require "rails_helper"

describe Eve::CategoryImporter do
  let(:category_id) { double }

  subject { described_class.new(category_id) }

  it { should be_a(Eve::BaseImporter) }

  describe "#initialize" do
    context "without locale" do
      its(:category_id) { should eq(category_id) }

      its(:locale) { should eq(:en) }
    end

    context "with locale" do
      let(:locale) { :ru }

      subject { described_class.new(category_id, locale) }

      its(:category_id) { should eq(category_id) }

      its(:locale) { should eq(:ru) }
    end
  end

  describe "#import" do
    before { expect(subject).to receive(:configure_middlewares) }

    let(:eve_category) { instance_double(Eve::Category) }

    before { expect(Eve::Category).to receive(:find_or_initialize_by).with(id: category_id).and_return(eve_category) }

    context "when eve category found" do
      let(:json) { double }

      let(:esi) { instance_double(EveOnline::ESI::UniverseCategory, as_json: json) }

      before { expect(subject).to receive(:esi).and_return(esi) }

      before { expect(eve_category).to receive(:update!).with(json) }

      specify { expect { subject.import }.not_to raise_error }
    end

    context "when eve category not found" do
      before { expect(subject).to receive(:esi).and_raise(EveOnline::Exceptions::ResourceNotFound) }

      before do
        #
        # Rails.logger.info("EveOnline::Exceptions::ResourceNotFound: Eve Category ID #{category_id}")

        expect(Rails).to receive(:logger) do
          double.tap do |a|
            expect(a).to receive(:info).with("EveOnline::Exceptions::ResourceNotFound: Eve Category ID #{category_id}")
          end
        end
      end

      before { expect(eve_category).to receive(:destroy!) }

      specify { expect { subject.import }.not_to raise_error }
    end
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseCategory) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::UniverseCategory) }

      before { expect(EveOnline::ESI::UniverseCategory).to receive(:new).with(id: category_id, language: "en-us").and_return(esi) }

      specify { expect(subject.esi).to eq(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
