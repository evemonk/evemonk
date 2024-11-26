# frozen_string_literal: true

module Eve
  class AlliancePolicy < ApplicationPolicy
    # @param user [User]
    # @param record [Eve::Alliance]
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
        Eve::Alliance.all
      end
    end
  end
end
