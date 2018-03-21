# frozen_string_literal: true

every 1.day do
  rake 'eve:races eve:bloodlines eve:factions eve:ancestries'
end
