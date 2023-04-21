# frozen_string_literal: true

class LinkPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def destroy?
    user&.admin? || user&.is_owner?(record.linkable)
  end
end
