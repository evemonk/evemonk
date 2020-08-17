# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :alliances,
      [Types::EveAllianceType],
      null: false,
      description: "Eve Alliances"

    field :alliance, Types::EveAllianceType, null: true do
      argument :id, ID, required: true
    end

    field :ancestries,
      [Types::EveAncestryType],
      null: false,
      description: "Eve Ancestries"

    field :ancestry, Types::EveAncestryType, null: true do
      argument :id, ID, required: true
    end

    field :bloodlines,
      [Types::EveBloodlineType],
      null: false,
      description: "Eve Bloodlines"

    field :bloodline, Types::EveBloodlineType, null: true do
      argument :id, ID, required: true
    end

    field :blueprints,
      [Types::EveBlueprintType],
      null: false,
      description: "Eve Blueprints"

    field :blueprint, Types::EveBlueprintType, null: true do
      argument :id, ID, required: true
    end

    field :categories,
      [Types::EveCategoryType],
      null: false,
      description: "Eve Categories"

    field :category, Types::EveCategoryType, null: true do
      argument :id, ID, required: true
    end

    field :characters,
      [Types::EveCharacterType],
      null: false,
      description: "Eve Characters"

    field :character, Types::EveCharacterType, null: true do
      argument :id, ID, required: true
    end

    field :constellations,
      [Types::EveConstellationType],
      null: false,
      description: "Eve Constellations"

    field :constellation, Types::EveConstellationType, null: true do
      argument :id, ID, required: true
    end

    field :contracts,
      [Types::EveContractType],
      null: false,
      description: "Public Contracts"

    field :contract, Types::EveContractType, null: true do
      argument :id, ID, required: true
    end

    field :corporations,
      [Types::EveCorporationType],
      null: false,
      description: "Eve Corporations"

    field :corporation, Types::EveCorporationType, null: true do
      argument :id, ID, required: true
    end

    field :factions,
      [Types::EveFactionType],
      null: false,
      description: "Eve Factions"

    field :faction, Types::EveFactionType, null: true do
      argument :id, ID, required: true
    end

    field :graphics,
      [Types::EveGraphicType],
      null: false,
      description: "Eve Graphics"

    field :graphic, Types::EveGraphicType, null: true do
      argument :id, ID, required: true
    end

    field :groups,
      [Types::EveGroupType],
      null: false,
      description: "Eve Groups"

    field :group, Types::EveGroupType, null: true do
      argument :id, ID, required: true
    end

    field :icons,
      [Types::EveIconType],
      null: false,
      description: "Eve Icons"

    field :icon, Types::EveIconType, null: true do
      argument :id, ID, required: true
    end

    field :market_groups,
      [Types::EveMarketGroupType],
      null: false,
      description: "Eve Market Groups"

    field :market_group, Types::EveMarketGroupType, null: true do
      argument :id, ID, required: true
    end

    field :races,
      [Types::EveRaceType],
      null: false,
      description: "Eve Races"

    field :race, Types::EveRaceType, null: true do
      argument :id, ID, required: true
    end

    field :regions,
      [Types::EveRegionType],
      null: false,
      description: "Eve Regions"

    field :region, Types::EveRegionType, null: true do
      argument :id, ID, required: true
    end

    field :ships,
      [Types::EveShipType],
      null: false,
      description: "Eve Ships"

    field :ship, Types::EveShipType, null: true do
      argument :id, ID, required: true
    end

    field :stars,
      [Types::EveStarType],
      null: false,
      description: "Eve Stars"

    field :star, Types::EveStarType, null: true do
      argument :id, ID, required: true
    end

    field :stations,
      [Types::EveStationType],
      null: false,
      description: "Eve Stations"

    field :station, Types::EveStationType, null: true do
      argument :id, ID, required: true
    end

    field :systems,
      [Types::EveSystemType],
      null: false,
      description: "Eve Systems"

    field :system, Types::EveSystemType, null: true do
      argument :id, ID, required: true
    end

    field :types,
      [Types::EveTypeType],
      null: false,
      description: "Eve Types"

    field :type, Types::EveTypeType, null: true do
      argument :id, ID, required: true
    end

    def alliances
      ::Eve::Alliance.lazy_preload(:creator_corporation,
        :creator,
        :executor_corporation,
        :faction)
        .all
        .decorate
    end

    def alliance(id:)
      ::Eve::Alliance.lazy_preload(:creator_corporation,
        :creator,
        :executor_corporation,
        :faction)
        .find_by(alliance_id: id)&.decorate
    end

    def ancestries
      ::Eve::Ancestry.all.decorate
    end

    def ancestry(id:)
      ::Eve::Ancestry.find_by(ancestry_id: id)&.decorate
    end

    def bloodlines
      ::Eve::Bloodline.all.decorate
    end

    def bloodline(id:)
      ::Eve::Bloodline.find_by(bloodline_id: id)&.decorate
    end

    def blueprints
      ::Eve::Blueprint.all.decorate
    end

    def blueprint(id:)
      ::Eve::Blueprint.find_by(type_id: id)&.decorate
    end

    def categories
      ::Eve::Category.all.decorate
    end

    def category(id:)
      ::Eve::Category.find_by(category_id: id)&.decorate
    end

    def characters
      ::Eve::Character.lazy_preload(:alliance,
        :ancestry,
        :bloodline,
        :corporation,
        :faction,
        :race,
        :character_corporation_histories)
        .all
        .decorate
    end

    def character(id:)
      ::Eve::Character.lazy_preload(:alliance,
        :ancestry,
        :bloodline,
        :corporation,
        :faction,
        :race,
        :character_corporation_histories)
        .find_by(character_id: id)&.decorate
    end

    def constellations
      ::Eve::Constellation.all.decorate
    end

    def constellation(id:)
      ::Eve::Constellation.find_by(constellation_id: id)&.decorate
    end

    def contracts
      ::Eve::Contract.all.decorate
    end

    def contract(id:)
      ::Eve::Contract.find_by(contract_id: id)&.decorate
    end

    def corporations
      ::Eve::Corporation.lazy_preload(:alliance,
        :ceo,
        :creator,
        :faction,
        :home_station,
        :characters)
        .all
        .decorate
    end

    def corporation(id:)
      ::Eve::Corporation.lazy_preload(:alliance,
        :ceo,
        :creator,
        :faction,
        :home_station,
        :characters)
        .find_by(corporation_id: id)&.decorate
    end

    def factions
      ::Eve::Faction.all.decorate
    end

    def faction(id:)
      ::Eve::Faction.find_by(faction_id: id)&.decorate
    end

    def graphics
      ::Eve::Graphic.all.decorate
    end

    def graphic(id:)
      ::Eve::Graphic.find_by(graphic_id: id)&.decorate
    end

    def groups
      ::Eve::Group.lazy_preload(:category, :types).decorate
    end

    def group(id:)
      ::Eve::Group.find_by(group_id: id)&.decorate
    end

    def icons
      ::Eve::Icon.all.decorate
    end

    def icon(id:)
      ::Eve::Icon.find_by(icon_id: id)&.decorate
    end

    def market_groups
      ::Eve::MarketGroup.all.decorate
    end

    def market_group(id:)
      ::Eve::MarketGroup.find_by(market_group_id: id)&.decorate
    end

    def races
      ::Eve::Race.lazy_preload(:faction).all.decorate
    end

    def race(id:)
      ::Eve::Race.lazy_preload(:faction)
        .find_by(race_id: id)&.decorate
    end

    def regions
      ::Eve::Region.all.decorate
    end

    def region(id:)
      ::Eve::Region.find_by(region_id: id)&.decorate
    end

    def ships
      # TODO: load only ships!!!
      ::Eve::Ship.lazy_preload(:group).all.decorate
    end

    def ship(id:)
      # TODO: load only ships!!!
      ::Eve::Ship.find_by(type_id: id)&.decorate
    end

    def stars
      ::Eve::Star.all.decorate
    end

    def star(id:)
      ::Eve::Star.find_by(star_id: id)&.decorate
    end

    def stations
      ::Eve::Station.all.decorate
    end

    def station(id:)
      ::Eve::Station.find_by(station_id: id)&.decorate
    end

    def systems
      ::Eve::System.all.decorate
    end

    def system(id:)
      ::Eve::System.find_by(system_id: id)&.decorate
    end

    def types
      ::Eve::Type.lazy_preload(:group).all.decorate
    end

    def type(id:)
      ::Eve::Type.find_by(type_id: id)&.decorate
    end
  end
end
