# frozen_string_literal: true

require "rails_helper"

describe CharacterIndustryJobsImporter do
  let(:character_id) { double }

  subject { described_class.new(character_id) }

  it { should be_a(CharacterBaseImporter) }

  describe "#initialize" do
    subject { described_class.new(character_id) }

    its(:character_id) { should eq(character_id) }
  end

  describe "#import!" do
    let(:character) { instance_double(Character) }

    before { expect(subject).to receive(:character).and_return(character) }

    let(:job_id) { double }

    let(:json) { double }

    let(:industry_job) { instance_double(EveOnline::ESI::Models::CharacterIndustryJob, job_id: job_id, as_json: json) }

    let(:esi) do
      instance_double(EveOnline::ESI::CharacterIndustryJobs,
        jobs: [industry_job])
    end

    before { expect(subject).to receive(:esi).and_return(esi) }

    let(:character_industry_job) { instance_double(IndustryJob) }

    before do
      #
      # character.industry_jobs.find_or_initialize_by(job_id: job.job_id)
      #
      expect(character).to receive(:industry_jobs) do
        double.tap do |a|
          expect(a).to receive(:find_or_initialize_by).with(job_id: job_id).and_return(character_industry_job)
        end
      end
    end

    before { expect(character_industry_job).to receive(:update!).with(json) }

    specify { expect { subject.import! }.not_to raise_error }
  end

  describe "#esi" do
    context "when @esi is set" do
      let(:esi) { instance_double(EveOnline::ESI::CharacterIndustryJobs) }

      before { subject.instance_variable_set(:@esi, esi) }

      specify { expect(subject.esi).to eq(esi) }
    end

    context "when @esi not set" do
      let(:esi) { instance_double(EveOnline::ESI::CharacterIndustryJobs) }

      let(:character) { instance_double(Character, character_id: character_id) }

      before { expect(subject).to receive(:character).and_return(character) }

      before { expect(EveOnline::ESI::CharacterIndustryJobs).to receive(:new).with(character_id: character_id, include_completed: true).and_return(esi) }

      specify { expect { subject.esi }.to change { subject.instance_variable_get(:@esi) }.from(nil).to(esi) }
    end
  end
end
