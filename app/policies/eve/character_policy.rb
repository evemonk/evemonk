# frozen_string_literal: true

module Eve
  class CharacterPolicy < ApplicationPolicy
    # @param user [User]
    # @param record [Eve::Character]
    def initialize(user, record)
      @user = user
      @record = record
    end

    def show?
      true
    end

    def create?
      false
    end

    def new?
      false
    end

    def update?
      false
    end

    def edit?
      false
    end

    def destroy?
      false
    end

    class Scope < Scope
      def resolve
        Eve::Character.all
      end
    end
  end
end
