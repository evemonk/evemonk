# frozen_string_literal: true

json.character do
  json.id @character.character_id
  json.icon do
    json.tiny @character.icon_tiny
    json.small @character.icon_small
    json.medium @character.icon_medium
    json.large @character.icon_large
    json.huge @character.icon_huge
    json.gigantic @character.icon_gigantic
  end
  json.name @character.name
  json.description @character.description
  json.birthday @character.birthday
  json.gender @character.gender
  json.security_status @character.security_status
  json.perception @character.perception
  json.memory @character.memory
  json.willpower @character.willpower
  json.intelligence @character.intelligence
  json.charisma @character.charisma
  json.wallet @character.wallet
  json.bonus_remaps @character.bonus_remaps
  json.last_remap_date @character.last_remap_date
  json.accrued_remap_cooldown_date @character.accrued_remap_cooldown_date

  if @character.alliance
    json.partial! partial: "api/eve/shared/alliance",
                  locals: {alliance: @character.alliance}
  end

  if @character.ancestry
    json.partial! partial: "api/eve/shared/ancestry",
                  locals: {ancestry: @character.ancestry}
  end

  if @character.bloodline
    json.partial! partial: "api/eve/shared/bloodline",
                  locals: {bloodline: @character.bloodline}
  end

  if @character.corporation
    json.partial! partial: "api/eve/shared/corporation",
                  locals: {corporation: @character.corporation}
  end

  if @character.faction
    json.partial! partial: "api/eve/shared/faction",
                  locals: {faction: @character.faction}
  end

  if @character.race
    json.partial! partial: "api/eve/shared/race",
                  locals: {race: @character.race}
  end
end
