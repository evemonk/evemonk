# frozen_string_literal: true

require "rails_helper"

describe "Welcome page feature" do
  it "should render page with alliances and corporations" do
    # Let's make sure that we show in testing mode real icons for alliances
    alliance_ids = [1_354_830_081, 99_009_268, 99_005_338, 99_003_581,
      1_900_696_668, 99_003_214, 498_125_261, 99_007_969, 99_009_163,
      99_010_921, 99_009_885, 99_009_752, 1_411_711_376, 1_727_758_877,
      99_010_386, 99_003_006, 937_872_513, 99_010_376, 1_042_504_553,
      99_011_048]

    alliance_ids.each { |alliance_id| create(:eve_alliance, id: alliance_id) }

    # Let's make sure that we show in testing mode real icons for corporations
    corporation_ids = [98_388_312, 98_258_093, 98_631_684, 98_370_861,
      98_399_497, 98_536_418, 98_169_165, 98_336_271, 98_575_483, 98_403_734,
      98_124_121, 98_324_027, 98_637_669, 917_701_062, 98_195_963, 98_261_065,
      98_595_110, 98_631_060, 1_018_389_948, 98_558_506]

    corporation_ids.each { |corporation_id| create(:eve_corporation, corporation_id: corporation_id, npc: false) }

    visit root_path
  end
end
