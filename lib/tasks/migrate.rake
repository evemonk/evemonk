# frozen_string_literal: true

namespace :migrate do
  # TODO: migrate eve_positions (polymorphic) before:
  # * asteroid belts
  # * stations
  # * planets
  # * stargates
  # * moons
  # * constellations
  # * systems

  desc "Migrate Eve::AsteroidBelt#asteroid_belt_id to #id"
  task asteroid_belts: :environment do
    Eve::AsteroidBelt.find_each do |asteroid_belt|
      asteroid_belt.update!(id: asteroid_belt.asteroid_belt_id)
    end
  end

  desc "Migrate Eve::Certificate#certificate_id to #id"
  task certificates: :environment do
    Eve::Certificate.find_each do |certificate|
      certificate.update!(id: certificate.certificate_id)
    end
  end

  desc "Migrate Eve::System#system_id to #id"
  task systems: :environment do
    Eve::System.find_each do |system|
      system.update!(id: system.system_id)
    end
  end

  desc "Migrate Eve::Station#station_id to #id"
  task stations: :environment do
    Eve::Station.find_each do |station|
      station.update!(id: station.station_id)
    end
  end

  desc "Migrate Eve::War#war_id to #id"
  task wars: :environment do
    Eve::War.find_each do |war|
      war.update!(id: war.war_id)
    end
  end

  desc "Migrate Eve::Constellation#constellation_id to #id"
  task constellations: :environment do
    Eve::Constellation.find_each do |constellation|
      constellation.update!(id: constellation.constellation_id)
    end
  end

  desc "Migrate Eve::Type#type_id to #id"
  task types: :environment do
    Eve::Type.find_each do |type|
      type.update!(id: type.type_id)
    end
  end

  desc "Migrate Eve::Star#star_id to #id"
  task stars: :environment do
    Eve::Star.find_each do |star|
      star.update!(id: star.star_id)
    end
  end

  desc "Migrate Eve::Stargate#stargate_id to #id"
  task stargates: :environment do
    Eve::Stargate.find_each do |stargate|
      stargate.update!(id: stargate.stargate_id)
    end
  end

  desc "Migrate Eve::Region#region_id to #id"
  task regions: :environment do
    Eve::Region.find_each do |region|
      region.update!(id: region.region_id)
    end
  end

  desc "Migrate Eve::Moon#moon_id to #id"
  task moons: :environment do
    Eve::Moon.find_each do |moon|
      moon.update!(id: moon.moon_id)
    end
  end

  desc "Migrate Eve::Planet#planet_id to #id"
  task planets: :environment do
    Eve::Planet.find_each do |planet|
      planet.update!(id: planet.planet_id)
    end
  end

  desc "Migrate Eve::Icon#icon_id to #id"
  task icons: :environment do
    Eve::Icon.find_each do |icon|
      icon.update!(id: icon.icon_id)
    end
  end

  desc "Migrate Eve::Graphic#graphic_id to #id"
  task graphics: :environment do
    Eve::Graphic.find_each do |graphic|
      graphic.update!(id: graphic.graphic_id)
    end
  end

  desc "Migrate Eve::Unit#unit_id to #id"
  task units: :environment do
    Eve::Unit.find_each do |unit|
      unit.update!(id: unit.unit_id)
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
