class UserDecorator < Draper::Decorator
  delegate_all

  # rubocop:disable Lint/UnusedMethodArgument
  def as_json(*args)
    {
      id: id,
      email: email,
      token: token
    }
  end
  # rubocop:enable Lint/UnusedMethodArgument
end
