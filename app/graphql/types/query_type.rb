# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    description "Query object"

    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :alliances,
      Types::EveAllianceType.connection_type,
      description: "Eve Alliances",
      null: true

    field :alliance,
      Types::EveAllianceType,
      description: "Eve Alliance",
      null: true do
      argument :id, ID, description: "Eve Alliance ID", required: true
    end

    field :ancestries,
      Types::EveAncestryType.connection_type,
      description: "Eve Ancestries",
      null: true

    field :ancestry,
      Types::EveAncestryType,
      description: "Eve Ancestry",
      null: true do
      argument :id, ID, description: "Eve Ancestry ID", required: true
    end

    field :bloodlines,
      Types::EveBloodlineType.connection_type,
      description: "Eve Bloodlines",
      null: true

    field :bloodline,
      Types::EveBloodlineType,
      description: "Eve Bloodline",
      null: true do
      argument :id, ID, description: "Eve Bloodline ID", required: true
    end

    field :blueprints,
      Types::EveBlueprintType.connection_type,
      description: "Eve Blueprints",
      null: true

    field :blueprint,
      Types::EveBlueprintType,
      description: "Eve Blueprint",
      null: true do
      argument :id, ID, description: "Eve Blueprint ID", required: true
    end

    field :categories, Types::EveCategoryType.connection_type, null: true, description: "Eve Categories"

    field :category, Types::EveCategoryType, null: true, description: "Eve Category" do
      argument :id, ID, required: true
    end

    field :characters, Types::EveCharacterType.connection_type, null: true, description: "Eve Characters"

    field :character, Types::EveCharacterType, null: true, description: "Eve Character" do
      argument :id, ID, required: true
    end

    field :constellations, Types::EveConstellationType.connection_type, null: true, description: "Eve Constellations"

    field :constellation, Types::EveConstellationType, null: true, description: "Eve Constellation" do
      argument :id, ID, required: true
    end

    field :contracts, Types::EveContractType.connection_type, null: true, description: "Public Contracts"

    field :contract, Types::EveContractType, null: true, description: "Public Contract" do
      argument :id, ID, required: true
    end

    field :corporations, Types::EveCorporationType.connection_type, null: true, description: "Eve Corporations"

    field :corporation, Types::EveCorporationType, null: true, description: "Eve Corporation" do
      argument :id, ID, required: true
    end

    field :factions, Types::EveFactionType.connection_type, null: true, description: "Eve Factions"

    field :faction, Types::EveFactionType, null: true, description: "Eve Faction" do
      argument :id, ID, required: true
    end

    field :graphics, Types::EveGraphicType.connection_type, null: true, description: "Eve Graphics"

    field :graphic, Types::EveGraphicType, null: true, description: "Eve Graphic" do
      argument :id, ID, required: true
    end

    field :groups, Types::EveGroupType.connection_type, null: true, description: "Eve Groups"

    field :group, Types::EveGroupType, null: true, description: "Eve Group" do
      argument :id, ID, required: true
    end

    field :icons, Types::EveIconType.connection_type, null: true, description: "Eve Icons"

    field :icon, Types::EveIconType, null: true, description: "Eve Icon" do
      argument :id, ID, required: true
    end

    field :market_groups, Types::EveMarketGroupType.connection_type, null: true, description: "Eve Market Groups"

    field :market_group, Types::EveMarketGroupType, null: true, description: "Eve Market Group" do
      argument :id, ID, required: true
    end

    field :races, Types::EveRaceType.connection_type, null: true, description: "Eve Races"

    field :race, Types::EveRaceType, null: true, description: "Eve Race" do
      argument :id, ID, required: true
    end

    field :regions, Types::EveRegionType.connection_type, null: true, description: "Eve Regions"

    field :region, Types::EveRegionType, null: true, description: "Eve Region" do
      argument :id, ID, required: true
    end

    field :ships, Types::EveShipType.connection_type, null: true, description: "Eve Ships"

    field :ship, Types::EveShipType, null: true, description: "Eve Ship" do
      argument :id, ID, required: true
    end

    field :stars, Types::EveStarType.connection_type, null: true, description: "Eve Stars"

    field :star, Types::EveStarType, null: true, description: "Eve Star" do
      argument :id, ID, required: true
    end

    field :stations, Types::EveStationType.connection_type, null: true, description: "Eve Stations"

    field :station, Types::EveStationType, null: true, description: "Eve Station" do
      argument :id, ID, required: true
    end

    field :systems, Types::EveSystemType.connection_type, null: true, description: "Eve Systems"

    field :system, Types::EveSystemType, null: true, description: "Eve System" do
      argument :id, ID, required: true
    end

    field :types, Types::EveTypeType.connection_type, null: true, description: "Eve Types"

    field :type, Types::EveTypeType, null: true, description: "Eve Type" do
      argument :id, ID, required: true
    end

    def alliances
      ::Eve::Alliance.preload_associations_lazily
        .order(:alliance_id)
    end

    def alliance(id:)
      ::Eve::Alliance.preload_associations_lazily
        .find_by(alliance_id: id)
    end

    def ancestries
      ::Eve::Ancestry.preload_associations_lazily
        .order(:ancestry_id)
    end

    def ancestry(id:)
      ::Eve::Ancestry.preload_associations_lazily
        .find_by(ancestry_id: id)
    end

    def bloodlines
      ::Eve::Bloodline.preload_associations_lazily
        .order(:bloodline_id)
    end

    def bloodline(id:)
      ::Eve::Bloodline.preload_associations_lazily
        .find_by(bloodline_id: id)
    end

    def blueprints
      ::Eve::Blueprint.preload_associations_lazily
        .order(:type_id)
    end

    def blueprint(id:)
      ::Eve::Blueprint.preload_associations_lazily
        .find_by(type_id: id)
    end

    def categories
      ::Eve::Category.preload_associations_lazily
        .order(:category_id)
    end

    def category(id:)
      ::Eve::Category.preload_associations_lazily
        .find_by(category_id: id)
    end

    def characters
      ::Eve::Character.preload_associations_lazily
        .order(:character_id)
    end

    def character(id:)
      ::Eve::Character.preload_associations_lazily
        .find_by(character_id: id)
    end

    def constellations
      ::Eve::Constellation.preload_associations_lazily
        .order(:constellation_id)
    end

    def constellation(id:)
      ::Eve::Constellation.preload_associations_lazily
        .find_by(constellation_id: id)
    end

    def contracts
      ::Eve::Contract.preload_associations_lazily
        .order(:contract_id)
    end

    def contract(id:)
      ::Eve::Contract.preload_associations_lazily
        .find_by(contract_id: id)
    end

    def corporations
      ::Eve::Corporation.preload_associations_lazily
        .order(:corporation_id)
    end

    def corporation(id:)
      ::Eve::Corporation.preload_associations_lazily
        .find_by(corporation_id: id)
    end

    def factions
      ::Eve::Faction.preload_associations_lazily
        .order(:faction_id)
    end

    def faction(id:)
      ::Eve::Faction.preload_associations_lazily
        .find_by(faction_id: id)
    end

    def graphics
      ::Eve::Graphic.preload_associations_lazily
        .order(:graphic_id)
    end

    def graphic(id:)
      ::Eve::Graphic.preload_associations_lazily
        .find_by(graphic_id: id)
    end

    def groups
      ::Eve::Group.preload_associations_lazily
        .order(:group_id)
    end

    def group(id:)
      ::Eve::Group.preload_associations_lazily
        .find_by(group_id: id)
    end

    def icons
      ::Eve::Icon.preload_associations_lazily
        .order(:icon_id)
    end

    def icon(id:)
      ::Eve::Icon.preload_associations_lazily
        .find_by(icon_id: id)
    end

    def market_groups
      ::Eve::MarketGroup.preload_associations_lazily
        .order(:market_group_id)
    end

    def market_group(id:)
      ::Eve::MarketGroup.preload_associations_lazily
        .find_by(market_group_id: id)
    end

    def races
      ::Eve::Race.preload_associations_lazily
        .order(:race_id)
    end

    def race(id:)
      ::Eve::Race.preload_associations_lazily
        .find_by(race_id: id)
    end

    def regions
      ::Eve::Region.preload_associations_lazily
        .order(:region_id)
    end

    def region(id:)
      ::Eve::Region.preload_associations_lazily
        .find_by(region_id: id)
    end

    def ships
      # TODO: load only ships!!!
      ::Eve::Ship.preload_associations_lazily
        .order(:type_id)
    end

    def ship(id:)
      # TODO: load only ships!!!
      ::Eve::Ship.preload_associations_lazily
        .find_by(type_id: id)
    end

    def stars
      ::Eve::Star.preload_associations_lazily
        .order(:star_id)
    end

    def star(id:)
      ::Eve::Star.preload_associations_lazily
        .find_by(star_id: id)
    end

    def stations
      ::Eve::Station.preload_associations_lazily
        .order(:station_id)
    end

    def station(id:)
      ::Eve::Station.preload_associations_lazily
        .find_by(station_id: id)
    end

    def systems
      ::Eve::System.preload_associations_lazily
        .order(:system_id)
    end

    def system(id:)
      ::Eve::System.preload_associations_lazily
        .find_by(system_id: id)
    end

    def types
      ::Eve::Type.preload_associations_lazily
        .order(:type_id)
    end

    def type(id:)
      ::Eve::Type.preload_associations_lazily
        .find_by(type_id: id)
    end
  end
end
