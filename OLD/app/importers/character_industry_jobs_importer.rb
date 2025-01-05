# frozen_string_literal: true

class CharacterIndustryJobsImporter < CharacterBaseImporter
  def import!
    esi.jobs.each do |job|
      character_industry_job = character.industry_jobs.find_or_initialize_by(job_id: job.job_id)

      character_industry_job.update!(job.as_json)
    end
  end

  def esi
    @esi ||= EveOnline::ESI::CharacterIndustryJobs.new(character_id: character.character_id,
      include_completed: true)
  end
end
