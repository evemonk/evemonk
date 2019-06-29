# frozen_string_literal: true

json.total_count @characters.total_count
json.total_pages @characters.total_pages
json.current_page @characters.current_page
json.characters do
  json.array! @characters do |character|
    json.id character.character_id
    json.icon "https://imageserver.eveonline.com/Character/#{ character.character_id }_512.jpg"
    json.birthday character.birthday.iso8601
    json.description Rails::Html::FullSanitizer.new.sanitize(character.description)
    json.gender character.gender
    json.name character.name
    json.security_status character.security_status.to_s
    json.title character.title

    if character.alliance
      json.alliance do
        json.id character.alliance.alliance_id
        json.creator_corporation_id character.alliance.creator_corporation_id
        json.creator_id character.alliance.creator_id
        json.date_founded character.alliance.date_founded.to_s
        json.executor_corporation_id character.alliance.executor_corporation_id
        json.faction_id character.alliance.faction_id
        json.name character.alliance.name
        json.ticker character.alliance.ticker
      end
    end

    if character.ancestry
      json.ancestry do
        json.id character.ancestry.ancestry_id
        json.bloodline_id character.ancestry.bloodline_id
        json.name character.ancestry.name
        json.short_description character.ancestry.short_description
        json.description character.ancestry.description
        json.icon_id character.ancestry.icon_id
      end
    end

    if character.bloodline
      json.bloodline do
        json.id character.bloodline.bloodline_id
        json.corporation_id character.bloodline.corporation_id
        json.race_id character.bloodline.race_id
        json.name character.bloodline.name
        json.description character.bloodline.description
        json.charisma character.bloodline.charisma
        json.intelligence character.bloodline.intelligence
        json.memory character.bloodline.memory
        json.perception character.bloodline.perception
        json.willpower character.bloodline.willpower
        json.ship_type_id character.bloodline.ship_type_id
      end
    end

    if character.corporation
      json.corporation do
        json.id character.corporation.corporation_id
        json.name character.corporation.name
        json.description character.corporation.description
        json.ticker character.corporation.ticker
        json.date_founded character.corporation.date_founded.iso8601
        json.url character.corporation.corporation_url
        json.member_count character.corporation.member_count
        json.shares character.corporation.shares
        json.tax_rate character.corporation.tax_rate.to_s
        json.alliance_id character.corporation.alliance_id
        json.ceo_id character.corporation.ceo_id
        json.creator_id character.corporation.creator_id
        json.faction_id character.corporation.faction_id
        json.home_station_id character.corporation.home_station_id
      end
    end

    if character.faction
      json.faction do
        json.id character.faction.faction_id
        json.corporation_id character.faction.corporation_id
        json.name character.faction.name
        json.description character.faction.description
        json.militia_corporation_id character.faction.militia_corporation_id
        json.solar_system_id character.faction.solar_system_id
        json.station_count character.faction.station_count
        json.station_system_count character.faction.station_system_count
        json.size_factor character.faction.size_factor.to_s
        json.is_unique character.faction.is_unique
      end
    end

    if character.race
      json.race do
        json.id character.race.race_id
        json.alliance_id character.race.alliance_id
        json.name character.race.name
        json.description character.race.description
      end
    end
  end
end
