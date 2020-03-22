# frozen_string_literal: true

class CharacterIndustryJobsImporter < CharacterBaseImporter
  def update!
    refresh_character_access_token

    esi = EveOnline::ESI::CharacterIndustryJobs.new(character_id: character.character_id,
                                                    token: character.access_token,
                                                    include_completed: true)

    return unless character_scope_present?(esi.scope)

    esi.jobs.each do |job|
      character_industry_job = character.industry_jobs.find_or_initialize_by(job_id: job.job_id)

      character_industry_job.update!(job.as_json)
    end
  end
end
