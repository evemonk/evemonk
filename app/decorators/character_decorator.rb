class CharacterDecorator < Draper::Decorator
  delegate_all

  def as_json(*)
    {
      uid: uid,
      name: name,
      created_at: created_at.iso8601,
      updated_at: updated_at.iso8601
    }
  end
end
