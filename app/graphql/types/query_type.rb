# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    description "Query object"

    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :agents, Types::EveAgentType.connection_type,
      description: "Agents",
      null: true

    field :agent, Types::EveAgentType,
      description: "Agent",
      null: true do
      argument :id, ID, description: "Agent ID", required: true
    end

    field :alliances, Types::EveAllianceType.connection_type,
      description: "Alliances",
      null: true

    field :alliance, Types::EveAllianceType,
      description: "Alliance",
      null: true do
      argument :id, ID, description: "Alliance ID", required: true
    end

    field :ancestries, Types::EveAncestryType.connection_type,
      description: "Ancestries",
      null: true

    field :ancestry, Types::EveAncestryType,
      description: "Ancestry",
      null: true do
      argument :id, ID, description: "Ancestry ID", required: true
    end

    field :bloodlines, Types::EveBloodlineType.connection_type,
      description: "Bloodlines",
      null: true

    field :bloodline, Types::EveBloodlineType,
      description: "Bloodline",
      null: true do
      argument :id, ID, description: "Bloodline ID", required: true
    end

    field :blueprints, Types::EveBlueprintType.connection_type,
      description: "Blueprints",
      null: true

    field :blueprint, Types::EveBlueprintType,
      description: "Blueprint",
      null: true do
      argument :id, ID, description: "Blueprint ID", required: true
    end

    field :categories, Types::EveCategoryType.connection_type,
      description: "Categories",
      null: true

    field :category, Types::EveCategoryType,
      description: "Category",
      null: true do
      argument :id, ID, description: "Category ID", required: true
    end

    field :certificates, Types::EveCertificateType.connection_type,
      description: "Certificates",
      null: true

    field :certificate, Types::EveCertificateType,
      description: "Certificate",
      null: true do
      argument :id, ID, description: "Certificate ID", required: true
    end

    field :characters, Types::EveCharacterType.connection_type,
      description: "Characters",
      null: true

    field :character, Types::EveCharacterType,
      description: "Character",
      null: true do
      argument :id, ID, description: "Character ID", required: true
    end

    field :constellations, Types::EveConstellationType.connection_type,
      description: "Constellations",
      null: true

    field :constellation, Types::EveConstellationType,
      description: "Constellation",
      null: true do
      argument :id, ID, description: "Constellation ID", required: true
    end

    field :contracts, Types::EveContractType.connection_type,
      description: "Public Contracts",
      null: true

    field :contract, Types::EveContractType,
      description: "Public Contract",
      null: true do
      argument :id, ID, description: "Contract ID", required: true
    end

    field :corporations, Types::EveCorporationType.connection_type,
      description: "Corporations",
      null: true

    field :corporation, Types::EveCorporationType,
      description: "Corporation",
      null: true do
      argument :id, ID, description: "Corporation ID", required: true
    end

    field :factions, Types::EveFactionType.connection_type,
      description: "Factions",
      null: true

    field :faction, Types::EveFactionType,
      description: "Faction",
      null: true do
      argument :id, ID, description: "Faction ID", required: true
    end

    field :graphics, Types::EveGraphicType.connection_type,
      description: "Graphics",
      null: true

    field :graphic, Types::EveGraphicType,
      description: "Graphic",
      null: true do
      argument :id, ID, description: "Graphic ID", required: true
    end

    field :groups, Types::EveGroupType.connection_type,
      description: "Groups",
      null: true

    field :group, Types::EveGroupType,
      description: "Group",
      null: true do
      argument :id, ID, description: "Group ID", required: true
    end

    field :icons, Types::EveIconType.connection_type,
      description: "Icons",
      null: true

    field :icon, Types::EveIconType,
      description: "Icon",
      null: true do
      argument :id, ID, description: "Icon ID", required: true
    end

    field :market_groups, Types::EveMarketGroupType.connection_type,
      description: "Market Groups",
      null: true

    field :market_group, Types::EveMarketGroupType,
      description: "Market Group",
      null: true do
      argument :id, ID, description: "Market Group ID", required: true
    end

    field :races, Types::EveRaceType.connection_type,
      description: "Races",
      null: true

    field :race, Types::EveRaceType,
      description: "Race",
      null: true do
      argument :id, ID, description: "Race ID", required: true
    end

    field :regions, Types::EveRegionType.connection_type,
      description: "Regions",
      null: true

    field :region, Types::EveRegionType,
      description: "Region",
      null: true do
      argument :id, ID, description: "Region ID", required: true
    end

    field :ships, Types::EveShipType.connection_type,
      description: "Ships",
      null: true

    field :ship, Types::EveShipType,
      description: "Ship",
      null: true do
      argument :id, ID, description: "Ship ID", required: true
    end

    field :stars, Types::EveStarType.connection_type,
      description: "Stars",
      null: true

    field :star, Types::EveStarType,
      description: "Star",
      null: true do
      argument :id, ID, description: "Star ID", required: true
    end

    field :stations, Types::EveStationType.connection_type,
      description: "Stations",
      null: true

    field :station, Types::EveStationType,
      description: "Station",
      null: true do
      argument :id, ID, description: "Station ID", required: true
    end

    field :systems, Types::EveSystemType.connection_type,
      description: "Systems",
      null: true

    field :system, Types::EveSystemType,
      description: "System",
      null: true do
      argument :id, ID, description: "System ID", required: true
    end

    field :types, Types::EveTypeType.connection_type,
      description: "Types",
      null: true

    field :type, Types::EveTypeType,
      description: "Type",
      null: true do
      argument :id, ID, description: "Type ID", required: true
    end

    field :units, Types::EveUnitType.connection_type,
      description: "Units",
      null: true

    field :unit, Types::EveUnitType,
      description: "Unit",
      null: true do
      argument :id, ID, description: "Unit ID", required: true
    end

    def agents
      ::Eve::Agent.order(:id)
    end

    def agent(id:)
      ::Eve::Agent.find_by(id: id)
    end

    def alliances
      ::Eve::Alliance.order(:id)
    end

    def alliance(id:)
      ::Eve::Alliance.find_by(id: id)
    end

    def ancestries
      ::Eve::Ancestry.order(:id)
    end

    def ancestry(id:)
      ::Eve::Ancestry.find_by(id: id)
    end

    def bloodlines
      ::Eve::Bloodline.order(:id)
    end

    def bloodline(id:)
      ::Eve::Bloodline.find_by(id: id)
    end

    def blueprints
      ::Eve::Blueprint.order(:type_id)
    end

    def blueprint(id:)
      ::Eve::Blueprint.find_by(type_id: id)
    end

    def categories
      ::Eve::Category.order(:id)
    end

    def category(id:)
      ::Eve::Category.find_by(id: id)
    end

    def certificates
      ::Eve::Certificate.order(:id)
    end

    def certificate(id:)
      ::Eve::Certificate.find_by(id: id)
    end

    def characters
      ::Eve::Character.order(:id)
    end

    def character(id:)
      ::Eve::Character.find_by(id: id)
    end

    def constellations
      ::Eve::Constellation.order(:constellation_id)
    end

    def constellation(id:)
      ::Eve::Constellation.find_by(constellation_id: id)
    end

    def contracts
      ::Eve::Contract.order(:contract_id)
    end

    def contract(id:)
      ::Eve::Contract.find_by(contract_id: id)
    end

    def corporations
      ::Eve::Corporation.order(:id)
    end

    def corporation(id:)
      ::Eve::Corporation.find_by(id: id)
    end

    def factions
      ::Eve::Faction.order(:id)
    end

    def faction(id:)
      ::Eve::Faction.find_by(id: id)
    end

    def graphics
      ::Eve::Graphic.order(:graphic_id)
    end

    def graphic(id:)
      ::Eve::Graphic.find_by(graphic_id: id)
    end

    def groups
      ::Eve::Group.order(:id)
    end

    def group(id:)
      ::Eve::Group.find_by(id: id)
    end

    def icons
      ::Eve::Icon.order(:icon_id)
    end

    def icon(id:)
      ::Eve::Icon.find_by(icon_id: id)
    end

    def market_groups
      ::Eve::MarketGroup.order(:market_group_id)
    end

    def market_group(id:)
      ::Eve::MarketGroup.find_by(market_group_id: id)
    end

    def races
      ::Eve::Race.order(:id)
    end

    def race(id:)
      ::Eve::Race.find_by(id: id)
    end

    def regions
      ::Eve::Region.order(:region_id)
    end

    def region(id:)
      ::Eve::Region.find_by(region_id: id)
    end

    def ships
      # TODO: load only ships!!!
      ::Eve::Ship.order(:type_id)
    end

    def ship(id:)
      # TODO: load only ships!!!
      ::Eve::Ship.find_by(type_id: id)
    end

    def stars
      ::Eve::Star.order(:star_id)
    end

    def star(id:)
      ::Eve::Star.find_by(star_id: id)
    end

    def stations
      ::Eve::Station.order(:station_id)
    end

    def station(id:)
      ::Eve::Station.find_by(station_id: id)
    end

    def systems
      ::Eve::System.order(:system_id)
    end

    def system(id:)
      ::Eve::System.find_by(system_id: id)
    end

    def types
      ::Eve::Type.order(:type_id)
    end

    def type(id:)
      ::Eve::Type.find_by(type_id: id)
    end

    def units
      ::Eve::Unit.order(:id)
    end

    def unit(id:)
      ::Eve::Unit.find_by(id: id)
    end
  end
end
