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

  describe "#update!" do
    context "when scope present" do
      before { expect(subject).to receive(:refresh_character_access_token) }

      let(:access_token) { double }

      let(:character) do
        instance_double(Character,
          character_id: character_id,
          access_token: access_token,
          scopes: "esi-industry.read_character_jobs.v1")
      end

      before { expect(subject).to receive(:character).and_return(character).exactly(4).times }

      let(:job_id) { double }

      let(:json) { double }

      let(:industry_job) { instance_double(EveOnline::ESI::Models::CharacterIndustryJob, job_id: job_id, as_json: json) }

      let(:esi) do
        instance_double(EveOnline::ESI::CharacterIndustryJobs,
          jobs: [industry_job],
          scope: "esi-industry.read_character_jobs.v1")
      end

      before { expect(EveOnline::ESI::CharacterIndustryJobs).to receive(:new).with(character_id: character_id, token: access_token, include_completed: true).and_return(esi) }

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

      specify { expect { subject.update! }.not_to raise_error }
    end

    context "when scope not present" do
      before { expect(subject).to receive(:refresh_character_access_token) }

      let(:access_token) { double }

      let(:character) do
        instance_double(Character,
          character_id: character_id,
          access_token: access_token,
          scopes: "")
      end

      before { expect(subject).to receive(:character).and_return(character).exactly(3).times }

      let(:esi) do
        instance_double(EveOnline::ESI::CharacterIndustryJobs,
          scope: "esi-industry.read_character_jobs.v1")
      end

      before { expect(EveOnline::ESI::CharacterIndustryJobs).to receive(:new).with(character_id: character_id, token: access_token, include_completed: true).and_return(esi) }

      before { expect(character).not_to receive(:industry_jobs) }

      specify { expect { subject.update! }.not_to raise_error }
    end
  end
end
