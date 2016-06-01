class UserDecorator < Draper::Decorator
  delegate_all

  def as_json(*args)
    {
      id: id,
      email: email,
      token: token
    }
  end
end
