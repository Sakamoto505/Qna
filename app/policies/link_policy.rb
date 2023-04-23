# frozen_string_literal: true

class LinkPolicy < ApplicationPolicy
  def destroy?
    user&.admin? || user&.is_owner?(record.linkable)
  end
end
