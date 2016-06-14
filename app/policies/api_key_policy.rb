class ApiKeyPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def create?
    true
  end

  def show?
    user.api_keys.include?(record)
  end

  def update?
    false
  end

  def destroy?
    user.api_keys.include?(record)
  end
end
