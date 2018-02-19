class CharacterSerializer
  include FastJsonapi::ObjectSerializer

  set_type :character

  attributes :id, :uid, :name, :security_status, :wallet, :charisma,
             :intelligence, :memory, :perception, :willpower,
             :bonus_remaps, :created_at, :updated_at
end
