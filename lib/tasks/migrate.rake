# frozen_string_literal: true

namespace :migrate do
  desc "Migrate Eve::Unit#unit_id to #id"
  task units: :environment do
    Eve::Unit.find_each do |unit|
      unit.update!(id: unit.unit_id)
    end
  end

  desc "Migrate Eve::Alliance#alliance_id to #id"
  task alliances: :environment do
    Eve::Alliance.find_each do |alliance|
      alliance.update!(id: alliance.alliance_id)
    end
  end

  desc "Migrate Eve::Agent#agent_id to #id"
  task agents: :environment do
    Eve::Agent.find_each do |agent|
      agent.update!(id: agent.agent_id)
    end
  end

  desc "Migrate Eve::Character#character_id to #id"
  task characters: :environment do
    Eve::Character.find_each do |character|
      character.update!(id: character.character_id)
    end
  end

  # TODO: remove this later
  desc "Migrate Eve::Certificate's"
  task certificates: :environment do
    Eve::CertificateRecommendedType.destroy_all
    Eve::CertificateSkill.destroy_all
    Eve::Certificate.destroy_all
  end
end
