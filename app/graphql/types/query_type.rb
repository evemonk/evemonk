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

    # blueprints
    # blueprint(id:)

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

    # constellations
    # constellation(id:)
    # contracts
    # contract(id:)

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

    # graphics
    # graphic(id:)

    field :groups,
      [Types::EveGroupType],
      null: false,
      description: "Eve Groups"

    field :group, Types::EveGroupType, null: true do
      argument :id, ID, required: true
    end

    # icons
    # icon(id:)
    # market_groups
    # market_group(id:)

    field :races,
      [Types::EveRaceType],
      null: false,
      description: "Eve Races"

    field :race, Types::EveRaceType, null: true do
      argument :id, ID, required: true
    end

    # regions
    # region(id:)
    # ships
    # ship(id:)
    # stars
    # star(id:)
    # stations
    # station(id:)
    # systems
    # system(id:)
    # types
    # type(id:)

    # field :blueprints,
    #   [Types::EveBlueprintType],
    #   null: false,
    #   description: "Eve Blueprints"
    #
    # field :ships,
    #   [Types::EveShipType],
    #   null: false,
    #   description: "Eve Ships"
    #
    # field :types,
    #   [Types::EveTypeType],
    #   null: false,
    #   description: "Eve Types"
    #
    # field :regions,
    #   [Types::EveRegionType],
    #   null: false,
    #   description: "Eve Regions"
    #
    # field :contracts,
    #   [Types::EveContractType],
    #   null: false,
    #   description: "Public Contracts"

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

    # blueprints
    # blueprint(id:)

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

    # constellations
    # constellation(id:)
    # contracts
    # contract(id:)

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

    # graphics
    # graphic(id:)

    def groups
      ::Eve::Group.lazy_preload(:category, :types).decorate
    end

    def group(id:)
      ::Eve::Group.find_by(group_id: id)&.decorate
    end

    # icons
    # icon(id:)
    # market_groups
    # market_group(id:)

    def races
      ::Eve::Race.lazy_preload(:faction).all.decorate
    end

    def race(id:)
      ::Eve::Race.lazy_preload(:faction)
        .find_by(race_id: id)&.decorate
    end

    # def blueprints
    #   ::Eve::Blueprint.lazy_preload(:group).all.decorate
    # end
    #
    # def ships
    #   # TODO: load only ships!!!
    #   ::Eve::Ship.lazy_preload(:group).all.decorate
    # end
    #
    # def types
    #   ::Eve::Type.lazy_preload(:group).all.decorate
    # end
    #
    # def regions
    #   ::Eve::Region.all.decorate
    # end
    #
    # def contracts
    #   ::Eve::Contract.all.decorate
    # end
  end
end
