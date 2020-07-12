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

    # bloodlines
    # bloodline(id:)
    # blueprints
    # blueprint(id:)
    # categories
    # category
    # characters
    # character(id:)
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

    # factions
    # faction(id:)
    # graphics
    # graphic(id:)
    # groups
    # group(id:)
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

    # field :characters,
    #   [Types::EveCharacterType],
    #   null: false,
    #   description: "Eve Characters"
    #
    # field :character, Types::EveCharacterType, null: true do
    #   argument :id, ID, required: true
    # end
    #
    # # field :factions,
    # #   [Types::EveFactionType],
    # #   null: false,
    # #   description: "Eve Factions"
    #
    # # field :bloodlines,
    # #   [Types::EveBloodlineType],
    # #   null: false,
    # #   description: "Eve Bloodlines"
    # #
    # # field :groups,
    # #   [Types::EveGroupType],
    # #   null: false,
    # #   description: "Eve Groups"
    # #
    # # field :blueprints,
    # #   [Types::EveBlueprintType],
    # #   null: false,
    # #   description: "Eve Blueprints"
    # #
    # # field :ships,
    # #   [Types::EveShipType],
    # #   null: false,
    # #   description: "Eve Ships"
    # #
    # # field :types,
    # #   [Types::EveTypeType],
    # #   null: false,
    # #   description: "Eve Types"
    # #
    # # field :regions,
    # #   [Types::EveRegionType],
    # #   null: false,
    # #   description: "Eve Regions"
    # #
    # # field :contracts,
    # #   [Types::EveContractType],
    # #   null: false,
    # #   description: "Public Contracts"

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

    # bloodlines
    # bloodline(id:)
    # blueprints
    # blueprint(id:)
    # categories
    # category
    # characters
    # character(id:)
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

    # factions
    # faction(id:)
    # graphics
    # graphic(id:)
    # groups
    # group(id:)
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

    # def characters
    #   ::Eve::Character.lazy_preload(:alliance,
    #                                 :ancestry,
    #                                 :bloodline,
    #                                 :corporation,
    #                                 :faction,
    #                                 :race,
    #                                 :character_corporation_histories)
    #     .all
    #     .decorate
    # end
    #
    # def character(id:)
    #   ::Eve::Character.lazy_preload(:alliance,
    #                                 :ancestry,
    #                                 :bloodline,
    #                                 :corporation,
    #                                 :faction,
    #                                 :race,
    #                                 :character_corporation_histories)
    #   .find_by(character_id: id)&.decorate
    # end
    #
    # # def factions
    # #   ::Eve::Faction.all.decorate
    # # end
    #
    # # def bloodlines
    # #   ::Eve::Bloodline.all.decorate
    # # end
    # #
    # # def groups
    # #   ::Eve::Group.all.decorate
    # # end
    # #
    # # def blueprints
    # #   ::Eve::Blueprint.lazy_preload(:group).all.decorate
    # # end
    # #
    # # def ships
    # #   # TODO: load only ships!!!
    # #   ::Eve::Ship.lazy_preload(:group).all.decorate
    # # end
    # #
    # # def types
    # #   ::Eve::Type.lazy_preload(:group).all.decorate
    # # end
    # #
    # # def regions
    # #   ::Eve::Region.all.decorate
    # # end
    # #
    # # def contracts
    # #   ::Eve::Contract.all.decorate
    # # end
  end
end
