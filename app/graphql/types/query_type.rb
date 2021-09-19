# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    description "Query object"

    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

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

    def alliances
      Goldiloader.enabled do
        ::Eve::Alliance.order(:alliance_id)
      end
    end

    def alliance(id:)
      Goldiloader.enabled do
        ::Eve::Alliance.find_by(alliance_id: id)
      end
    end

    def ancestries
      Goldiloader.enabled do
        ::Eve::Ancestry.order(:ancestry_id)
      end
    end

    def ancestry(id:)
      Goldiloader.enabled do
        ::Eve::Ancestry.find_by(ancestry_id: id)
      end
    end

    def bloodlines
      Goldiloader.enabled do
        ::Eve::Bloodline.order(:bloodline_id)
      end
    end

    def bloodline(id:)
      Goldiloader.enabled do
        ::Eve::Bloodline.find_by(bloodline_id: id)
      end
    end

    def blueprints
      Goldiloader.enabled do
        ::Eve::Blueprint.order(:type_id)
      end
    end

    def blueprint(id:)
      Goldiloader.enabled do
        ::Eve::Blueprint.find_by(type_id: id)
      end
    end

    def categories
      Goldiloader.enabled do
        ::Eve::Category.order(:category_id)
      end
    end

    def category(id:)
      Goldiloader.enabled do
        ::Eve::Category.find_by(category_id: id)
      end
    end

    def characters
      Goldiloader.enabled do
        ::Eve::Character.order(:character_id)
      end
    end

    def character(id:)
      Goldiloader.enabled do
        ::Eve::Character.find_by(character_id: id)
      end
    end

    def constellations
      Goldiloader.enabled do
        ::Eve::Constellation.order(:constellation_id)
      end
    end

    def constellation(id:)
      Goldiloader.enabled do
        ::Eve::Constellation.find_by(constellation_id: id)
      end
    end

    def contracts
      Goldiloader.enabled do
        ::Eve::Contract.order(:contract_id)
      end
    end

    def contract(id:)
      Goldiloader.enabled do
        ::Eve::Contract.find_by(contract_id: id)
      end
    end

    def corporations
      Goldiloader.enabled do
        ::Eve::Corporation.order(:corporation_id)
      end
    end

    def corporation(id:)
      Goldiloader.enabled do
        ::Eve::Corporation.find_by(corporation_id: id)
      end
    end

    def factions
      Goldiloader.enabled do
        ::Eve::Faction.order(:faction_id)
      end
    end

    def faction(id:)
      Goldiloader.enabled do
        ::Eve::Faction.find_by(faction_id: id)
      end
    end

    def graphics
      Goldiloader.enabled do
        ::Eve::Graphic.order(:graphic_id)
      end
    end

    def graphic(id:)
      Goldiloader.enabled do
        ::Eve::Graphic.find_by(graphic_id: id)
      end
    end

    def groups
      Goldiloader.enabled do
        ::Eve::Group.order(:group_id)
      end
    end

    def group(id:)
      Goldiloader.enabled do
        ::Eve::Group.find_by(group_id: id)
      end
    end

    def icons
      Goldiloader.enabled do
        ::Eve::Icon.order(:icon_id)
      end
    end

    def icon(id:)
      Goldiloader.enabled do
        ::Eve::Icon.find_by(icon_id: id)
      end
    end

    def market_groups
      Goldiloader.enabled do
        ::Eve::MarketGroup.order(:market_group_id)
      end
    end

    def market_group(id:)
      Goldiloader.enabled do
        ::Eve::MarketGroup.find_by(market_group_id: id)
      end
    end

    def races
      Goldiloader.enabled do
        ::Eve::Race.order(:race_id)
      end
    end

    def race(id:)
      Goldiloader.enabled do
        ::Eve::Race.find_by(race_id: id)
      end
    end

    def regions
      Goldiloader.enabled do
        ::Eve::Region.order(:region_id)
      end
    end

    def region(id:)
      Goldiloader.enabled do
        ::Eve::Region.find_by(region_id: id)
      end
    end

    def ships
      # TODO: load only ships!!!
      Goldiloader.enabled do
        ::Eve::Ship.order(:type_id)
      end
    end

    def ship(id:)
      # TODO: load only ships!!!
      Goldiloader.enabled do
        ::Eve::Ship.find_by(type_id: id)
      end
    end

    def stars
      Goldiloader.enabled do
        ::Eve::Star.order(:star_id)
      end
    end

    def star(id:)
      Goldiloader.enabled do
        ::Eve::Star.find_by(star_id: id)
      end
    end

    def stations
      Goldiloader.enabled do
        ::Eve::Station.order(:station_id)
      end
    end

    def station(id:)
      Goldiloader.enabled do
        ::Eve::Station.find_by(station_id: id)
      end
    end

    def systems
      Goldiloader.enabled do
        ::Eve::System.order(:system_id)
      end
    end

    def system(id:)
      Goldiloader.enabled do
        ::Eve::System.find_by(system_id: id)
      end
    end

    def types
      Goldiloader.enabled do
        ::Eve::Type.order(:type_id)
      end
    end

    def type(id:)
      Goldiloader.enabled do
        ::Eve::Type.find_by(type_id: id)
      end
    end
  end
end
